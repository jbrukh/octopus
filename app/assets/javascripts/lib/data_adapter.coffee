App.DataAdapter = Em.Object.extend Ember.Evented,
  init: ->
    @set 'state', 'stopped'

  isRunning: (->
    @get('state') == 'running'
  ).property('state')

  start: ->
    console.log 'starting data adapter'
    @set 'state', 'running'
    @trigger 'didStart'
    @_start()

  stop: ->
    @_stop()
    @trigger 'didStop'
    @set 'state', 'stopped'

App.DataAdapter.reopenClass
  available: ['live', 'mock']

  build: (connector, type, properties) ->
    console.log "create data adapter: #{type}"
    dataAdapter = switch type
      when 'mock' then App.MockDataAdapter.create(properties)
      when 'live' then  App.WebSocketDataAdapter.create(properties)
      else throw "unknown data adapter type #{type}"
    dataAdapter.set 'connector', connector
    dataAdapter