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
    # cast message id as a string and set the message type
    # only assign an id if hasn't already been set for testing
    # use the number of ms since midnight as the identifier

    d = new Date()
    d.setHours(0,0,0,0)
    msSinceMidnight = new Date() - d

    message.id = "" + msSinceMidnight if message.id == undefined
    message.message_type = message_type

    console.log "Sending connector message: #{message_type} (#{message.id})"

    deferred = @next(message)

    if @get('isConnected')
      @ws.sendJson(message)
    else
      console.log "Buffering message: #{message_type}"
      @bufferedMessages.push(message)

    deferred

  onMessage: (data) ->
    console.group 'Connector response'

    # decode the data and then dispatch it
    @decode data, (callbackId, data) =>
      @dispatch(callbackId, data)

  decode: (data, onDecode) ->
    return @decodeString(data, onDecode) if @isString(data)
    return @decodeBlob(data, onDecode) if data instanceof Blob

    type = Object.prototype.toString.call(data)
    throw "No decode available for type #{type}"

  dispatch: (callbackId, response) ->
    console.log "Dispatching #{callbackId}"

    deferred = @callbacks[callbackId]
    # if we get a message from the connector which we
    # have no callback for, for example it might send us
    # a message without an ID for any reason, we should log
    # that fact and then not resolve a response handler
    if deferred == undefined
      console.warn "Could not find deferred callback for id: #{callbackId}"
    else
      delete @callbacks[callbackId]
      deferred.resolve(response)
    console.groupEnd()

  decodeString: (string, onDecode) ->
    parsed = JSON.parse(string)
    console.debug parsed
    onDecode(parsed.id, parsed)

  decodeBlob: (blob, onDecode) ->
    console.log blob

    fileReader = new FileReader()
    fileReader.onload = ->
      # read the array buffer
      arrayBuffer = @result

      # create a dataview to read the callback id
      dataView = new DataView(arrayBuffer, 0, 4)
      callbackId = "" + dataView.getUint32(0, false)

      # execute on decode with callback id, create dataview
      # offset to actual data we care about
      onDecode(callbackId, new DataView(arrayBuffer, 4))

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
    @set 'pairingId', response.pairing_id

    @sendBufferedMessages()

  sendBufferedMessages: ->
    return if @bufferedMessages.length == 0
    console.log "Sending #{@bufferedMessages.length} buffered message(s)"
    @bufferedMessages.forEach (m) =>
      @ws.sendJson(m)
    @bufferedMessages = []