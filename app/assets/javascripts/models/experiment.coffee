App.Experiment = Em.Object.extend
  isSetup: (->
    @get('state') == 'setup'
  ).property('state')

  isCalibrating: (->
    @get('state') == 'calibrating'
  ).property('state')

  calibrate: ->
    @set 'state', 'calibrating'

App.Experiment.reopenClass
  begin: ->
    App.Experiment.create
      state: 'setup'