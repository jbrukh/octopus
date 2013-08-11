App.RecordingsIndexRoute = Em.Route.extend
  redirect: ->
    settings = App.Settings.find()
    tab = settings.get('layout.last_recording_tab') || 'cloud'
    @transitionTo "recordings.#{tab}"