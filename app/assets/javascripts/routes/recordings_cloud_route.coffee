App.RecordingsCloudRoute = Em.Route.extend
  model: ->
    App.Recording.findQuery({page: 1})

  activate: ->
    settings = App.Settings.find()
    settings.set('layout.last_recording_tab', 'cloud')
    settings.save()
