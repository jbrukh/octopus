App.SettingsIndexRoute = Ember.Route.extend
  model: -> App.Settings.find()
  setupController: (controller, params) ->
    controller.set 'dataAdapters', App.DataAdapter.available