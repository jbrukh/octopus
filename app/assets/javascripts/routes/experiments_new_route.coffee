App.ExperimentsNewRoute = Ember.Route.extend
  model: ->
    @transaction = @get('store').transaction()
    return @transaction.createRecord App.Experiment

  deactivate: ->
    @transaction.rollback() if @transaction

  events:
    save: ->
      @currentModel.on 'didCreate', =>
        Ember.run.next this, =>
          @transitionTo 'experiment', @currentModel
      @transaction.commit()