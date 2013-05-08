App.Trial = Em.Object.extend
  isSetup: (->
    @get('state') == 'setup'
  ).property('state')

  isCalibrating: (->
    @get('state') == 'calibrating'
  ).property('state')

  isRunning: (->
    @get('state') == 'running'
  ).property('state')

  calibrate: ->
    @set 'state', 'calibrating'

  run: ->
    @set 'state', 'running'

App.Trial.reopenClass
  begin: ->
    App.Trial.create
      state: 'setup'