App.ExperimentStartController = Em.ObjectController.extend
  calibrate: ->
    @get('model').calibrate()