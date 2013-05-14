App.MessageBus = Em.Object.extend
  start: ->
    console.log 'Starting message bus'
    url = "ws://#{window.location.host}/api/events"
    console.log url
    socket = new WebSocket(url)

    socket.onmessage = (event) ->
      console.log JSON.parse(event.data)