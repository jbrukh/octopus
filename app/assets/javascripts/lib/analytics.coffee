analytics =
  identify: (user) ->
    return unless App.Environment == 'production'

    email = user.get 'email'
    role = user.get 'role'

    mixpanel.identify email
    mixpanel.name_tag email

    mixpanel.people.set
      '$email': email
      '$last_login': new Date()
      'role': role

  track: (event_name, properties = {}) ->
    return unless App.Environment == 'production'
    mixpanel.track(event_name, properties)

  track_pageview: ->
    return unless App.Environment == 'production'
    mixpanel.track_pageview()

root = exports ? this
root.analytics = analytics