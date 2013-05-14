App.Connector = Em.Object.extend
  url: 'ws://localhost:8000/control'
  callbacks: []

  init: ->
    @set 'state', 'disconnected'

  isConnected: (->
    return @get('state') == 'connected'
  ).property('state')

  isConnecting: (->
    return @get('state') == 'connecting'
  ).property('state')

  connect: ->
    console.log "Connecting to connector: #{this.url}"
    @ws = @createWebsocket(this.url)

  createWebsocket: (url) ->
    ws = App.WebSocketFactory.createWebSocket(url)
    @set 'state', 'connecting'
    ws.onopen = () =>
      console.log "Connector socket open"
      @set 'state', 'connected'
      @send('info').then((d) => @onUpdateInfo(d))

    ws.onmessage = (evt) =>
      response = JSON.parse(evt.data)
      console.debug "Connector response: #{response}"
      deferred = @callbacks[response.id]
      # if we get a message from the connector which we
      # have no callback for, for example it might send us
      # a message without an ID for any reason, we should log
      # that fact and then not resolve a response handler
      if deferred == undefined
        console.warn "Could not find deferred for: #{evt.data}"
        return
      deferred.resolve(response)

    ws.onerror = () =>
      console.error "!!! Connector socket error..."
      @set 'state', 'disconnected'

    ws.onclose = () =>
      console.warn "!!! Connector socket close"
      @set 'state', 'disconnected'
    ws

  send: (message_type, object = {}) ->
    console.log "Sending connector message: #{message_type}"
    # create a deferred callback which will be used
    # as the response handler for the correlated message
    # id
    deferred = Ember.Deferred.create()

    #cast messageid as a string and build the serialized message
    object.id = "" + new Date().getTime()
    object.message_type = message_type
    serialized = JSON.stringify(object)

    # stash the deferred and send the message
    @callbacks[object.id] = deferred
    @ws.send(serialized)
    deferred

  onUpdateInfo: (response) ->
    @set 'device_name', response.device_name
    @set 'version', response.version