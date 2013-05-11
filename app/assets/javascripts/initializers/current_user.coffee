Ember.Application.initializer
  name: 'currentUser'

  initialize: (container) ->
    store = container.lookup('store:main')
    curretUserAttributes = $('meta[name="current-user"]').attr('content')

    if curretUserAttributes
      # parsed the current-user meta tag
      parsed = JSON.parse(curretUserAttributes)

      # load and fetch the logged in user
      object = store.load(App.User, parsed)
      user = App.User.find(object.id)

      # set an auth_token header on every request
      # which will be used by the API to authenticate
      token = parsed.authentication_token
      header = "auth_token #{token}"
      $.ajaxSetup({beforeSend: (jqXHR) ->
        jqXHR.setRequestHeader("Authorization", header);
      });

      # set current user on every controller
      controller = container.lookup('controller:currentUser').set('content', user)
      container.typeInjection('controller', 'currentUser', 'controller:currentUser')