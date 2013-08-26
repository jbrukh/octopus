App.ExperimentsNewRoute = Ember.Route.extend
  model: ->
    App.Experiment.create()

  events:
    save: ->
      @currentModel.save().then =>
        @transitionTo 'experiment', @currentModel
