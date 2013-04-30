App.VideosIndexRoute = Ember.Route.extend
  model: -> App.Video.find()