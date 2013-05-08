App.ExperimentsIndexRoute = Ember.Route.extend
  model: -> App.Experiment.find()