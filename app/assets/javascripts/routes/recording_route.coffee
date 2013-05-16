App.RecordingRoute = Em.Route.extend
  setupController: (params, controller) ->
    controller.set 'tag', App.Tag.create()