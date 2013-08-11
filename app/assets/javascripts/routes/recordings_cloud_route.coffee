App.RecordingsCloudRoute = Em.Route.extend
  model: -> App.Recording.find()

  activate: ->
    settings = App.Settings.find()
    settings.set('layout.last_recording_tab', 'cloud')
    settings.save()