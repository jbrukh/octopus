Ember.Application.initializer
  name: 'message_bus'

  initialize: (container) ->
    messageBus = App.MessageBus.create()
    messageBus.start()

    container.register 'message_bus:instance', messageBus, {'instantiate': false}
    container.typeInjection 'controller', 'message_bus', 'message_bus:instance'
    container.typeInjection 'route', 'message_bus', 'message_bus:instance'
