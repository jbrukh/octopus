App.ParticipantsNewRoute = Em.Route.extend
  model: ->
    @transaction = @get('store').transaction()
    return @transaction.createRecord(App.Participant, {})

  deactivate: ->
    @transaction.rollback() if @transaction

  events:
    save: ->
      console.log 'Saving participant'

      @currentModel.one 'didCreate', =>
        @transitionTo 'participant', @currentModel

      @currentModel.one 'becameInvalid', =>
        console.log 'Participant is invalid'

      @transaction.commit()