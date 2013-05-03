App.ExperimentStartController = Em.ObjectController.extend
  calibrate: ->
    @get('model').calibrate()
    Ember.run.next this, () -> @get('dataAdapter').start()

  run: ->
    @get('model').run()