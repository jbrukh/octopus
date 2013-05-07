App.SlideshowsIndexRoute = Ember.Route.extend
  model: -> App.Slideshow.find()