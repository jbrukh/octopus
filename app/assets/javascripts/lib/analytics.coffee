analytics =
  identify: (user) ->
    debugger
    return unless App.Environment == 'production'

    email = user.get 'email'
    role = user.get 'role'

    mixpanel.people.set({
      '$email': email,
      '$last_login': new Date(),
      'role': role
    })

    mixpanel.identify email
    mixpanel.name_tag email

  track: (event_name, properties = {}) ->
    console.group "Analytics Track: #{event_name}"
    console.debug properties
    console.groupEnd()
    return unless App.Environment == 'production'
    mixpanel.track(event_name, properties)

  track_pageview: ->
    return unless App.Environment == 'production'
    mixpanel.track_pageview()

root = exports ? this
root.analytics = analytics