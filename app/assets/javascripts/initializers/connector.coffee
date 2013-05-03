Ember.Application.initializer
  name: 'connector'

  initialize: (container) ->
    container.register 'connector:instance', App.Connector
    container.typeInjection 'controller', 'connector', 'connector:instance'
    container.typeInjection 'route', 'connector', 'connector:instance'