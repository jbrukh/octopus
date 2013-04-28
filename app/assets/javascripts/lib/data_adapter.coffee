App.DataAdapter = Em.Object.extend()

App.DataAdapter.reopenClass
  available: ['live', 'mock']

  create: (type, properties) ->
    console.log "create data adapter: #{type}"
    switch type
      when 'mock' then App.MockDataAdapter.create(properties)
      when 'live' then  App.WebSocketDataAdapter.create(properties)
      else throw "unknown data adapter type #{type}"