App.WebSocketFactory =
  createWebSocket: (url) ->

    # add method on websocket prototype to
    # sendJson, this is useful so we can mock out calls
    # with objects and write expectations
    WebSocket.prototype.sendJson = (obj) ->
      serialized = JSON.stringify(obj)
      this.send(serialized)

    # create a new websocket with the requested url
    webSocket = new WebSocket(url)
