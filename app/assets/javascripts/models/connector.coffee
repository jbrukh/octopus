App.Connector = Em.Object.extend
  url: 'ws://localhost:8000/control'
  callbacks: []
  bufferedMessages: []

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
      data = evt.data
      @onMessage(data)

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

  send: (message_type, message = {}) ->
    console.log "Sending connector message: #{message_type}"

    # cast message id as a string and set the message type
    # only assign an id if hasn't already been set for testing
    message.id = "" + new Date().getTime() if message.id == undefined
    message.message_type = message_type

    deferred = @next(message)

    if @get('isConnected')
      @ws.sendJson(message)
    else
      console.log "Buffering message: #{message_type}"
      @bufferedMessages.push(message)

    deferred

  onMessage: (data) ->
    console.group 'Connector response'

    @decode data, (callback, data) =>
      @dispatch(callback, data)

  decode: (data, callback) ->
    return @decodeString(data, callback) if @isString(data)
    return @decodeBlob(data, callback) if data instanceof Blob

    type = Object.prototype.toString.call(data)
    throw "No decode available for type #{type}"

  dispatch: (callback, response) ->
    deferred = @callbacks[callback]
    # if we get a message from the connector which we
    # have no callback for, for example it might send us
    # a message without an ID for any reason, we should log
    # that fact and then not resolve a response handler
    if deferred == undefined
      console.warn "Could not find deferred callback for id: #{callback}"
    else
      delete @callbacks[callback]
      deferred.resolve(response)
    console.groupEnd()

  decodeString: (string, callback) ->
    parsed = JSON.parse(string)
    console.debug parsed
    callback(parsed.id, parsed)

  decodeBlob: (blob, callback) ->
    console.log blob

    fileReader = new FileReader()
    fileReader.onload = ->
      callback('1234', @result)

    fileReader.readAsArrayBuffer blob

  isString: (o) ->
    typeof o == "string" || (typeof o == "object" && o.constructor == String)

  next: (message) ->
    # create a deferred callback which will be used
    # as the response handler for the correlated message
    # id
    deferred = Ember.Deferred.create()

    # stash the deferred and send the message
    @callbacks[message.id] = deferred

    deferred

  onInfo: (response) ->
    @set 'device_name', response.device_name
    @set 'version', response.version

    @sendBufferedMessages()

  sendBufferedMessages: ->
    return if @bufferedMessages.length == 0
    console.log "Sending #{@bufferedMessages.length} buffered message(s)"
    @bufferedMessages.forEach (m) =>
      @ws.sendJson(m)
    @bufferedMessages = []