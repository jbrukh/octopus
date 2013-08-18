App.StatusIndexRoute = Ember.Route.extend
  events:
    goToEditUser: ->
      window.location = "http://#{window.location.host}/users/edit"
