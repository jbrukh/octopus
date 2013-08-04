App.RecordingsIndexRoute = Em.Route.extend
  redirect: ->
    @transitionTo 'recordings.cloud'