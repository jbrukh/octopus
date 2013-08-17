Ember.Application.initializer
  name: 'uploader',
  after: "connector",

  initialize: (container) ->
    connector = container.lookup('connector:instance')
    currentUser = container.lookup('controller:currentUser').get('model')

    s3BucketName  = $('meta[name="s3-bucket-name"]').attr('content')
    s3AccessKeyId = $('meta[name="s3-access-key-id"]').attr('content')

    uploader = App.Uploader.create
      connector:      connector
      currentUser:    currentUser
      s3BucketName:   s3BucketName
      s3AccessKeyId:  s3AccessKeyId

    # register it with the container so we can use it in routes and controllers
    container.register 'uploader:instance', uploader, { 'instantiate': false }

    container.typeInjection 'controller', 'uploader', 'uploader:instance'
    container.typeInjection 'route',      'uploader', 'uploader:instance'