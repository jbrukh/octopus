App.RecordingsIndexRoute = Em.Route.extend
  model: -> App.Recording.find()