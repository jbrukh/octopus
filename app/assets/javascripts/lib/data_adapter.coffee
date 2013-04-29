App.DataAdapter = Em.Object.extend()

App.DataAdapter.reopenClass
  available: ['live', 'mock']

  create: (connector, type, properties) ->
    console.log "create data adapter: #{type}"
    dataAdapter = switch type
      when 'mock' then App.MockDataAdapter.create(properties)
      when 'live' then  App.WebSocketDataAdapter.create(properties)
      else throw "unknown data adapter type #{type}"
    dataAdapter.set 'connector', connector
    dataAdapter