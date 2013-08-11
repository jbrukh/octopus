App.RecordingCloudRoute = Em.Route.extend
  events:
    editRecording: ->
      @render 'modal', { into: 'application', outlet: 'modal' }

    close: ->
      @disconnectOutlet { outlet: 'modal', parentView: 'application' }

  setupController: (controller, model) ->
    @_super(controller, model)
    controller.set 'tagging', App.Tagging.create()