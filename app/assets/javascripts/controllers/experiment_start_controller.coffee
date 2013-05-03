App.ExperimentStartController = Em.ObjectController.extend Ember.Evented,
  calibrate: ->
    @get('model').calibrate()
    Ember.run.next this, () -> @get('dataAdapter').start()

  run: ->
    @get('model').run()
    ##Ember.run.later this, (() ->
     # console.log 'going fullscreen'
    #  @trigger 'onFullscreen'), 500

    Ember.run.later this, (() ->
      console.log 'playing'
      @trigger 'onPlay'), 1000