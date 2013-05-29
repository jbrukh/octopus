App.RecordingRoute = Em.Route.extend
  setupController: (controller, model) ->
    @_super(controller, model)
    controller.set 'tagging', App.Tagging.createRecord()