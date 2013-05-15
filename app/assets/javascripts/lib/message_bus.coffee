App.MessageBus = Em.Object.extend
  start: ->
    url = "ws://#{window.location.host}/api/events"

    console.log "Connecting to message bus: #{url}"

    #socket = new WebSocket(url)
    #socket.onmessage = (event) ->
    #  console.log JSON.parse(event.data)