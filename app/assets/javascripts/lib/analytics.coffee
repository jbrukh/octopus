analytics =
  identify: (identity) ->
    return unless App.Environment == 'production'
    mixpanel.identify identity

  track: (event_name, properties = {}) ->
    return unless App.Environment == 'production'
    mixpanel.track(event_name, properties)

  track_pageview: ->
    return unless App.Environment == 'production'
    mixpanel.track_pageview()

root = exports ? this
root.analytics = analytics