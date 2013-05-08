App.SettingsIndexController = Ember.Controller.extend
  save: ->
      @get('model').save().then =>
        @transitionToRoute 'recordings.new'

  reset: ->
    @set 'model', App.Settings.createRecord()