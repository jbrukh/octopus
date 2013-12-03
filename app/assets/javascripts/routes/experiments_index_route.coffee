App.ExperimentsIndexRoute = Ember.Route.extend
  model: ->
    @get('store').find('experiment')
