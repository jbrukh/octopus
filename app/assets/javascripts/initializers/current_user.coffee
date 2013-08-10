Ember.Application.initializer
  name: 'currentUser'

  initialize: (container) ->
    curretUserAttributes = $('meta[name="current-user"]').attr('content')

    if curretUserAttributes
      # parsed the current-user meta tag
      parsed = JSON.parse(curretUserAttributes)

      # create a load the user
      user = App.User.create()
      user.load(parsed.id, parsed)

      # identify this user with analytics
      analytics.identify user.get('email')

      # set an auth_token header on every request
      # which will be used by the API to authenticate
      token = parsed.authentication_token
      header = "auth_token #{token}"
      $.ajaxSetup({beforeSend: (jqXHR) ->
        jqXHR.setRequestHeader("Authorization", header);
      });

      # set current user on every controller
      container.lookup('controller:currentUser').set('content', user)
      container.typeInjection('controller', 'currentUser', 'controller:currentUser')