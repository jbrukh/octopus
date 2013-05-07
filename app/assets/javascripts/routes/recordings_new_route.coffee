App.RecordingsNewRoute = Ember.Route.extend
  model: () ->
    App.Recording.createRecord()

  activate: ->
    controller = @controllerFor('recordings.new')
    settings = App.Settings.find()
    connector = @get('connector')
    controller.set 'dataAdapter', App.DataAdapter.buildFromSettings(connector, settings)