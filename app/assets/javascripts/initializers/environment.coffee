Ember.Application.initializer
  name: 'environment'

  initialize: (container) ->
    environment = $('meta[name="environment"]').attr('content')
    App.Environment = environment if environment