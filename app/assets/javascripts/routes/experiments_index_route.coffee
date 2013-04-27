App.ExperimentsIndexRoute = Ember.Route.extend
  setupController: (controller, params) ->
    controller.set 'dataAdapters', ['mock', 'live']
    controller.set 'selectedDataAdapter', 'mock'

  activate: ->
    controller = @controllerFor('experiments.index')
    controller.set 'settings', App.Settings.find()