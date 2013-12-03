Ember.Application.initializer
  name: 'currentUser'
  after: "environment",

  initialize: (container) ->
    currentUserAttributes = $('meta[name="current-user"]').attr('content')

    if currentUserAttributes
      # parsed the current-user meta tag
      parsed = JSON.parse(currentUserAttributes)

      # create a load the user
      store = container.lookup('store:main')
      store.pushPayload('user', {users: [parsed]})
      user = store.getById('user', parsed.id)

      # identify this user with analytics
      analytics.identify user

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
