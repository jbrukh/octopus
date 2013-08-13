attr = Ember.attr

App.User = Ember.Model.extend
  id:                   attr()
  firstName:            attr()
  lastName:             attr()
  email:                attr()
  role:                 attr()
  password:             attr()
  passwordConfirmation: attr()
  authenticationToken:  attr()

App.User.url = "/api/users"
App.User.rootKey = 'user'
App.User.camelizeKeys = true
App.User.adapter = Ember.RESTAdapter.create()