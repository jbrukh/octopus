App.ParticipantsNewRoute = Em.Route.extend
  model: ->
    App.Participant.create()

  actions:
    save: ->
      console.log 'Saving participant'

      result = @currentModel.save()

      # if the model succesfully saves then show the new participant
      result.then () =>
        analytics.track 'create participant'
        @transitionTo 'participant', @currentModel

      # if the model has validation errors then show an invalid
      # participant message
      result.then null, (err) =>
        console.log err
        @set 'controller.hasValidationErrors', true