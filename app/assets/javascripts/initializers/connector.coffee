Ember.Application.initializer
  name: 'connector'
  after: 'currentUser'

  initialize: (container) ->
    console.group 'Initializing connector'

    connector = App.Connector.create()

    container.register 'connector:instance', connector, {'instantiate': false}
    container.typeInjection 'controller', 'connector', 'connector:instance'
    container.typeInjection 'route', 'connector', 'connector:instance'

    console.debug 'registered connector'

    currentUser = container.lookup('controller:currentUser')

    if currentUser.get('isSignedIn')
      console.debug 'user signed in, auto connecting'
      connector.connect()
    else
      console.debug 'user not signed in, not auto-connecting'

    console.groupEnd()