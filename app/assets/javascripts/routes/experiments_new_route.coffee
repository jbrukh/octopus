App.ExperimentsNewRoute = Ember.Route.extend
  model: ->
    @get('store').createRecord('experiment')

  actions:
    save: ->
      @currentModel.save().then =>
        @transitionTo 'experiment', @currentModel
