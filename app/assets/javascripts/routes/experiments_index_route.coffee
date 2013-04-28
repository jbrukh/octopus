App.ExperimentsIndexRoute = Ember.Route.extend
  activate: ->
    controller = @controllerFor('experiments.index')
    settings = App.Settings.find()

    adapter = settings.get('adapters.selected')
    properties = settings.get("adapters.#{adapter}")

    controller.set 'dataAdapter', App.DataAdapter.create(adapter, properties)