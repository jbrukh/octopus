App.TheoriesNewRoute = Ember.Route.extend
  model: -> null

  setupController: (controller) ->
    controller.startEditing()

  deactivate: ->
    @controllerFor('theories.new').stopEditing()