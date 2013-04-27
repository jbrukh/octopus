App.DataAdapter = Em.Object.extend()

App.DataAdapter.reopenClass
  create: (type, settings) ->
    adapterSettings = settings.get("adapters.#{type}")
    if type == 'mock'
      return App.MockDataAdapter.create(adapterSettings)

    if type == 'live'
      return App.WebSocketDataAdapter.create
        url: 'ws://localhost:8000/device'