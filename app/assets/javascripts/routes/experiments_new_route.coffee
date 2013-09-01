App.ExperimentsNewRoute = Ember.Route.extend
  model: ->
    App.Experiment.create()

  actions:
    save: ->
      @currentModel.save().then =>
        @transitionTo 'experiment', @currentModel
