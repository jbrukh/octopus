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
    @ws = @createWebsocket(this.url)

  createWebsocket: (url) ->
    console.debug "creating new websocket: #{url}"
    ws = new WebSocket(url)
    @set 'state', 'connecting'
    ws.onopen = () =>
      console.log "connector socket open"
      @set 'state', 'connected'
      @send('info').then((d) => @onUpdateInfo(d))

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
    ws

  send: (message_type, object = {}) ->
    console.log "sending #{message_type}"
    # create a deferred callback which will be used
    # as the response handler for the correlated message
    # id
    deferred = Ember.Deferred.create()

    #cast messageid as a string and build the serialized message
    object.id = "" + @currentMessageId++
    object.message_type = message_type
    serialized = JSON.stringify(object)

    # stash the deferred and send the message
    @callbacks[object.id] = deferred
    @ws.send(serialized)
    deferred

  onUpdateInfo: (response) ->
    @set 'device_name', response.device_name
    @set 'version', response.version