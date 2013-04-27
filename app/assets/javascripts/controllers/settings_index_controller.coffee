App.SettingsIndexController = Ember.Controller.extend
  save: ->
      console.log 'saving settings'
      @get('model').save().then =>
        @transitionToRoute 'index'