App.ParticipantsIndexRoute = Em.Route.extend
  model: ->
    @get('store').find 'participant', { page: 1 }
