App.RecordingRoute = Em.Route.extend
  setupController: (params, controller) ->
    controller.set 'tagging', App.Tagging.createRecord()