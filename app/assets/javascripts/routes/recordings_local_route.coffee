App.RecordingsLocalRoute = Em.Route.extend
  model: ->
    App.LocalRecording.findQuery({})

  activate: ->
    settings = App.Settings.find()
    settings.set('layout.last_recording_tab', 'local')
    settings.save()