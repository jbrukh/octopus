App.DataAdapter = Em.Object.extend Ember.Evented,

  manager: Ember.StateManager.create
    initialState: 'stopped'

    # state manager begins in the stopped state
    stopped: Ember.State.create()
    negotiating: Ember.State.create()
    running:  Ember.State.create()

    start: (manager, adapter) ->
      console.log 'starting data adapter'
      manager.send 'negotiate', adapter

    negotiate: (manager, adapter) ->
      manager.transitionTo 'negotiating'
      adapter._start()

    run: (manager, adapter) ->
      adapter.trigger 'didStart'
      manager.transitionTo 'running'

  isRunning: (->
    @get('manager.currentState.name') == 'running'
  ).property('manager.currentState')

  start: ->
    @manager.send 'start', this

  stop: ->
    @_stop()
    @trigger 'didStop'
    @manager.transitionTo 'stopped'

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

  buildFromSettings: (connector, settings) ->
    adapter = settings.get('adapters.selected')
    properties = settings.get("adapters.#{adapter}")
    App.DataAdapter.build(connector, adapter, properties)