App.SettingsIndexController = Ember.Controller.extend
  save: ->
      @get('model').save().then =>
        @transitionToRoute 'experiments'

  reset: ->
    @set 'model', App.Settings.createRecord()