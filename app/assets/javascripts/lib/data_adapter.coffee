App.DataAdapter = Em.Object.extend Ember.Evented,
  frame: null
  receivedFrames: 0

  manager: Ember.StateManager.create
    initialState: 'stopped'

    # state manager begins in the stopped state
    stopped:      Ember.State.create()
    negotiating:  Ember.State.create()
    running:      Ember.State.create()
    failed:       Ember.State.create()

    start: (manager, adapter) ->
      console.log 'starting data adapter'
      manager.send 'negotiate', adapter

    negotiate: (manager, adapter) ->
      manager.transitionTo 'negotiating'
      adapter._start()

    run: (manager, adapter) ->
      adapter.trigger 'didStart'
      manager.transitionTo 'running'

  isNegotiating: (->
    @get('manager.currentState.name') == 'negotiating'
  ).property('manager.currentState')

  isRunning: (->
    @get('manager.currentState.name') == 'running'
  ).property('manager.currentState')

  isFailed: (->
    @get('manager.currentState.name') == 'failed'
  ).property('manager.currentState')

  start: ->
    @manager.send 'start', this

  stop: ->
    @_stop()
    @frame = null
    @trigger 'didStop'
    @manager.transitionTo 'stopped'

  sample: ->
    @frame

  frameReceived: (f) ->
    # if we have no frame set, use it to complete the
    # negotiation state and transition to runnnig state
    if @frame == null
      @set 'channels', f.length
      @manager.send 'run', this

    @frame = f
    @incrementProperty('receivedFrames')

App.DataAdapter.reopenClass
  build: (connector, type, properties) ->
    console.log "Create data adapter: #{type}"
    dataAdapter = App.WebSocketDataAdapter.create(properties)
    dataAdapter.set 'connector', connector
    dataAdapter

  buildFromSettings: (connector, settings) ->
    adapter = settings.get('adapters.selected')
    properties = settings.get("adapters.#{adapter}")
    App.DataAdapter.build(connector, adapter, properties)