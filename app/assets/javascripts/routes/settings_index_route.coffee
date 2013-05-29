App.SettingsIndexRoute = Ember.Route.extend
  model: ->
    App.Settings.find()

  setupController: (controller, model) ->
    @_super(controller, model)
    controller.set 'dataAdapters', App.DataAdapter.available