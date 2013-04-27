App.ExperimentsIndexController = Ember.Controller.extend Ember.Evented,
  start: ->
    console.log 'starting experiment'
    @set 'isRunning', true
    @get('dataAdapter').start()
    @trigger 'didStart'

  stop: ->
    console.log 'stopping experiment'
    @set 'isRunning', false

    @get('dataAdapter').stop()
    @trigger 'didStop'

  changeDataAdapter: (->
    adapterType = @get 'selectedDataAdapter'
    settings = @get 'settings'
    @set 'dataAdapter', App.DataAdapter.create(adapterType, settings)
  ).observes('selectedDataAdapter')