App.RecordingCloudRoute = Em.Route.extend
  actions:
    edit: ->
      @set 'controller.newName', @get('controller.name')
      @set 'controller.newDescription', @get('controller.description')
      @render 'modal', { into: 'application', outlet: 'modal' }

    close: ->
      @disconnectOutlet { outlet: 'modal', parentView: 'application' }

  setupController: (controller, model) ->
    @_super(controller, model)
    controller.set 'tagging', App.Tagging.create()