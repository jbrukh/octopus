App.MessageBus = Em.Object.extend
  start: ->
    console.log "Connecting to message bus"
    #source = new EventSource('/api/events')
    #source.addEventListener 'recording.updated', (e) ->
    #  console.log e