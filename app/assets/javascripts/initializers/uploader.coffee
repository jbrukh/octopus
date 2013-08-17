Ember.Application.initializer
  name: 'uploader',
  after: "connector",

  initialize: (container) ->
    connector = container.lookup('connector:instance')
    currentUser = container.lookup('controller:currentUser').get('model')

    uploader = App.Uploader.create
      connector:    connector
      currentUser:  currentUser

    # register it with the container so we can use it in routes and controllers
    container.register 'uploader:instance', uploader, { 'instantiate': false }

    container.typeInjection 'controller', 'uploader', 'uploader:instance'
    container.typeInjection 'route',      'uploader', 'uploader:instance'