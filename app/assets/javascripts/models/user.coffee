attr = DS.attr

App.User = DS.Model.extend
  firstName:            attr()
  lastName:             attr()
  email:                attr()
  role:                 attr()
  password:             attr()
  passwordConfirmation: attr()
  authenticationToken:  attr()
  organization:         attr()

  isAdmin: (->
    @get('role') == 'admin'
  ).property('role')

#App.User.url = "/api/users"
#App.User.rootKey = 'user'
#App.User.camelizeKeys = true
#App.User.adapter = Ember.RESTAdapter.create()