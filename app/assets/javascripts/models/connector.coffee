App.Connector = Em.Object.extend
  url: 'ws://localhost:8000/device'

  init: ->
    console.log 'creating connector'
    @set 'state', 'disconnected'
    @connect()

  isConnected: (->
    return @get('state') == 'connected'
  ).property('state')

  connect: ->
    console.log "connecting to websocket: #{this.url}"

    # set the state to connected and
    # create a new websocket
    @set 'state', 'connecting'
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
    @connect() if(@ws.readyState == 0 || @ws.readyState == 3)

  createWebsocket: (url) ->
    ws = new WebSocket('ws://localhost:8000/device')
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
      console.log "connector socket error"
      @set 'state', 'disconnected'
      #setTimeout((() => @checkConnected()), 2000)

    ws.onclose = () =>
      console.log "connector socket close"
      @set 'state', 'disconnected'
      #setTimeout((() => @checkConnected()), 2000)
    return ws