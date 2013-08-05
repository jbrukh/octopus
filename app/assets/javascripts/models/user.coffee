attr = Ember.attr

App.User = Ember.Model.extend
  email:                attr()
  role:                 attr()
  password:             attr()
  passwordConfirmation: attr()
  authenticationToken:  attr()

App.User.url = "/api/users"
App.User.rootKey = 'user'
App.User.camelizeKeys = true
App.User.adapter = Ember.RESTAdapter.create()