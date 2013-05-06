App.RecordingsNewRoute = Ember.Route.extend
  model: () ->
    App.Recording.create()

  activate: ->
    controller = @controllerFor('recordings.new')
    settings = App.Settings.find()
    connector = @get('connector')
    controller.set 'dataAdapter', App.DataAdapter.buildFromSettings(connector, settings)