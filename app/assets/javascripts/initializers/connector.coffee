Ember.Application.initializer
  name: 'connector'

  initialize: (container) ->
    connector = App.Connector.create()
    connector.connect()

    container.register 'connector:instance', connector, {'instantiate': false}
    container.typeInjection 'controller', 'connector', 'connector:instance'
    container.typeInjection 'route', 'connector', 'connector:instance'

