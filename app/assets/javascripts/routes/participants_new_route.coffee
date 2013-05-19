App.ParticipantsNewRoute = Em.Route.extend
  model: ->
    @transaction = @get('store').transaction()
    return @transaction.createRecord(App.Participant, {})

  deactivate: ->
    @transaction.rollback() if @transaction

  events:
    save: ->
      @currentModel.on 'didCreate', =>
        @transitionTo 'participant', @currentModel
      @transaction.commit()