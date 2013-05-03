App.ExperimentsIndexRoute = Ember.Route.extend
  activate: ->
    controller = @controllerFor('experiments.index')
    settings = App.Settings.find()
    connector = @get('connector')
    controller.set 'dataAdapter', App.DataAdapter.buildFromSettings(connector, settings)