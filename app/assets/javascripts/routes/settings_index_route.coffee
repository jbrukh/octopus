App.SettingsIndexRoute = Ember.Route.extend
  model: -> App.Settings.find()