App.RecordingsLocalRoute = Em.Route.extend
  model: -> App.LocalRecording.find()