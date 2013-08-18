App.ParticipantsPageRoute = Em.Route.extend
  setupController: ->
    @controllerFor('participants.index').set('model', @currentModel)

  model: (params) ->
    App.Participant.findQuery({page: params.page_id})

  renderTemplate: ->
    @render 'participants.index', { controller: 'participantsIndex' }
