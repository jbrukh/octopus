App.RegistrationsNewRoute = Em.Route.extend
  model: ->
    return App.User.createRecord
      email: 'email',
      password: 'password',
      passwordConfirmation: 'password'

  events:
    register: ->
      @currentModel.save().then () =>
        @transitionTo 'index'