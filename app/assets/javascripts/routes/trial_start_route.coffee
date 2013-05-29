App.TrialStartRoute = Em.Route.extend
  model: ->
    @experiment = this.modelFor("experiment")
    @experiment.startTrial()

  setupController: (controller, params) ->
    @_super(controller, model)

    settings = App.Settings.find()
    connector = @get('connector')
    controller.set 'dataAdapter', App.DataAdapter.buildFromSettings(connector, settings)