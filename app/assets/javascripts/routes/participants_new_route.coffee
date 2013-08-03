App.ParticipantsNewRoute = Em.Route.extend
  model: ->
    App.Participant.create()

  events:
    save: ->
      console.log 'Saving participant'

      @currentModel.save().then =>
        @transitionTo 'participant', @currentModel