App.VideosNewRoute = Ember.Route.extend
  model: ->
    App.Video.create()

  events:
    save: ->
      result = @currentModel.save()

      result.then =>
        analytics.track 'create video'
        @transitionTo 'video', @currentModel