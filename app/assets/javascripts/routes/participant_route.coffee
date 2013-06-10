App.ParticipantRoute = Em.Route.extend
  setupController: (controller, model) ->
    @_super(controller, model)
    controller.set 'recordings', App.Recording.find({participant_id: model.get('id')})