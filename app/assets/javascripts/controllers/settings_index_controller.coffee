App.SettingsIndexController = Ember.Controller.extend
  save: ->
      @get('model').save().then =>
        @transitionToRoute 'index'

  reset: ->
    @set 'model', App.Settings.createRecord()