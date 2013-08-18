App.ParticipantsIndexRoute = Em.Route.extend
  model: ->
    App.Participant.findQuery({page: 1})
