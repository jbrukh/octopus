App.Connector = Em.Object.extend
  url: 'ws://localhost:8000/control'
  currentMessageId: 1
  callbacks: []

  init: ->
    console.log 'creating connector'
    @set 'state', 'disconnected'
    @connect()

  isConnected: (->
    return @get('state') == 'connected'
  ).property('state')

  isConnecting: (->
    return @get('state') == 'connecting'
  ).property('state')

  connect: ->
    console.log "connecting to websocket: #{this.url}"

    # set the state to connected and
    # create a new websocket
    @ws = @createWebsocket(this.url)

    # schedule a check to make sure we're connected
    # in the future
    setTimeout((() => @checkConnected()), 2000)

  checkConnected: ->
    # ready state 0 is not yet established
    # ready state 3 is error or cannot connect
    return if @get('isConnecting')
    @connect() if(@ws.readyState == 0 || @ws.readyState == 3)

  createWebsocket: (url) ->
    console.debug "creating new websocket"
    ws = new WebSocket(url)
    @set 'state', 'connecting'
    ws.onopen = () =>
      console.log "connector socket open"
      @set 'state', 'connected'
      @send({ message_type: 'info' }).then((d) => @onUpdateInfo(d))

    ws.onmessage = (evt) =>
      response = JSON.parse(evt.data)
      deferred = @callbacks[response.id]
      deferred.resolve(response)

    ws.onerror = () =>
      console.error "Connector socket error..."
      @set 'state', 'disconnected'

    ws.onclose = () =>
      console.warn "connector socket close"
      @set 'state', 'disconnected'
      setTimeout((() => @checkConnected()), 2000)
    ws

  send: (object) ->
    deferred = Ember.Deferred.create()
    object.id = "" + @currentMessageId++
    serialized = JSON.stringify(object)
    @callbacks[object.id] = deferred
    @ws.send(serialized)
    deferred

  onUpdateInfo: (response) ->
    @set 'device_name', response.device_name
    @set 'version', response.version