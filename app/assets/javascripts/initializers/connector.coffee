Ember.Application.initializer
  name: 'connector'
  after: 'currentUser'

  initialize: (container) ->
    console.group 'Initializing connector'

    # create an instance of the connector
    connector = App.Connector.create()

    # register it with the container so we can use it in routes and controllers
    container.register 'connector:instance', connector, { 'instantiate': false }

    container.typeInjection 'controller', 'connector', 'connector:instance'
    container.typeInjection 'route', 'connector', 'connector:instance'

    # register it with the connector adapter so we can use it to load models
    App.ConnectorAdapter.connectorInstance = connector

    console.debug 'registered connector'

    # if we're a signed in user then connect automatically
    currentUser = container.lookup('controller:currentUser')

    if currentUser.get('isSignedIn')
      console.debug 'user signed in, auto connecting'
      connector.connect()
    else
      console.debug 'user not signed in, not auto-connecting'

    console.groupEnd()