App.Connector = Em.Object.extend
  url: 'ws://localhost:8000/control'
  callbacks: []
  bufferedMessages: []
  resources: Em.A []

  init: ->
    @set 'state', 'disconnected'

  numCallbacks: ->
    Object.keys(@callbacks).length

  isConnected: (->
    return @get('state') == 'connected'
  ).property('state')

  isConnecting: (->
    return @get('state') == 'connecting'
  ).property('state')

  hasBufferedMessages: ->
    @bufferedMessages.length > 0

  connect: ->
    console.log "Connecting to connector: #{this.url}"
    @ws = @createWebsocket(this.url)

  createWebsocket: (url) ->
    ws = App.WebSocketFactory.createWebSocket(url)
    @set 'state', 'connecting'

    ws.onopen = () =>
      @onOpen()

    ws.onmessage = (evt) =>
      response = JSON.parse(evt.data)
      @onResponse(response)

    ws.onerror = () =>
      console.error "!!! Connector socket error..."
      @set 'state', 'disconnected'

    ws.onclose = () =>
      console.warn "!!! Connector socket close"
      @set 'state', 'disconnected'
    ws

  onOpen: () ->
    console.log "Connector socket open"
    @set 'state', 'connected'
    @send('info').then((d) => @onInfo(d))

  send: (message_type, object = {}) ->
    console.log "Sending connector message: #{message_type}"
    # create a deferred callback which will be used
    # as the response handler for the correlated message
    # id
    deferred = Ember.Deferred.create()

    # cast message id as a string and set the message type
    # only assign an id if hasn't already been set for testing
    object.id = "" + new Date().getTime() if object.id == undefined
    object.message_type = message_type

    # stash the deferred and send the message
    @callbacks[object.id] = deferred

    if @get('isConnected')
      @ws.sendJson(object)
    else
      console.log "Buffering message: #{message_type}"
      @bufferedMessages.push(object)

    deferred

  onResponse: (response) ->
    console.group 'Connector response'
    console.debug response

    deferred = @callbacks[response.id]
    # if we get a message from the connector which we
    # have no callback for, for example it might send us
    # a message without an ID for any reason, we should log
    # that fact and then not resolve a response handler
    if deferred == undefined
      console.warn "Could not find deferred callback for response..."
    else
      delete @callbacks[response.id]
      deferred.resolve(response)
    console.groupEnd()

  onInfo: (response) ->
    @set 'device_name', response.device_name
    @set 'version', response.version

    @send('repository', {operation: 'list'}).then(
      (d) => @onRepository(d))

    @sendBufferedMessages()

  sendBufferedMessages: ->
    return if @bufferedMessages.length == 0
    console.log "Sending #{@bufferedMessages.length} buffered message(s)"
    @bufferedMessages.forEach (m) =>
      @ws.sendJson(m)
    @bufferedMessages = []

  onRepository: (response) ->
    @set 'resources', Em.A(response.resource_infos)

  clearRepository: () ->
    @send('repository', {operation: 'clear'}).then(() =>
      @set 'resources', Em.A([])
    )