App.Connector = Em.Object.extend
  url: 'ws://localhost:8000/device'

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

  sendObject: (object) ->
    serialized = JSON.stringify(object)
    @ws.send(serialized)

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
      initialize = {
        connect: true,
        frequency: 100,
        average: false
      }
      @sendObject(initialize)

    ws.onmessage = (evt) =>
      null

    ws.onerror = () =>
      console.error "Connector socket error..."
      @set 'state', 'disconnected'

    ws.onclose = () =>
      console.warn "connector socket close"
      @set 'state', 'disconnected'
      setTimeout((() => @checkConnected()), 2000)
    return ws