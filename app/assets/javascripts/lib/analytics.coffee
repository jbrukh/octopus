analytics =
  track: (event) ->
    return unless App.Environment == 'production'
    mixpanel.track(event)

  track_pageview: ->
    return unless App.Environment == 'production'
    mixpanel.track_pageview()

root = exports ? this
root.analytics = analytics