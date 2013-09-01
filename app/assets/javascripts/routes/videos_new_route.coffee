App.VideosNewRoute = Ember.Route.extend
  model: ->
    App.Video.create()

  actions:
    save: ->
      result = @currentModel.save()

      result.then =>
        analytics.track 'create video'
        @transitionTo 'video', @currentModel