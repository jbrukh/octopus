App.ExperimentStartRoute = Em.Route.extend
  model: -> App.Experiment.begin()

  setupController: (controller, params) ->
    settings = App.Settings.find()
    connector = @get('connector')
    controller.set 'dataAdapter', App.DataAdapter.buildFromSettings(connector, settings)