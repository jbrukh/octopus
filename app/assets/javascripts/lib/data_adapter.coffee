App.DataAdapter = Em.Object.extend()

App.DataAdapter.reopenClass
  available: ['live', 'mock']

  create: (type, properties) ->
    console.log "create data adapter: #{type}"
    if type == 'mock'
      return App.MockDataAdapter.create(properties)

    if type == 'live'
      return App.WebSocketDataAdapter.create
        url: 'ws://localhost:8000/device'