App.StatusIndexRoute = Ember.Route.extend
  actions:
    goToEditUser: ->
      window.location = "http://#{window.location.host}/users/edit"
