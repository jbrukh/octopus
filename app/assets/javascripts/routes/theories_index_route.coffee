App.TheoriesIndexRoute = Ember.Route.extend
  model: -> App.Theory.find()