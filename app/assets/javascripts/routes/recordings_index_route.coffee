App.RecordingsIndexRoute = Ember.Route.extend
  activate: ->
    controller = @controllerFor('recordings.index')
    settings = App.Settings.find()
    connector = @get('connector')
    controller.set 'dataAdapter', App.DataAdapter.buildFromSettings(connector, settings)