App.TrialStartRoute = Em.Route.extend
  model: -> App.Trial.begin()

  setupController: (controller, params) ->
    settings = App.Settings.find()
    connector = @get('connector')
    controller.set 'dataAdapter', App.DataAdapter.buildFromSettings(connector, settings)