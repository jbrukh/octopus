App.WebSocketFactory =
  createWebSocket: (url) ->
    new WebSocket(url)