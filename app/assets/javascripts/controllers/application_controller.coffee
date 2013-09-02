App.ApplicationController = Ember.Controller.extend
  routeChanged: (->
    Em.run.next ->
      analytics.track_pageview(window.location.href)
  ).observes('currentPath')

  actions:
    goToSignIn: ->
      window.location = "http://#{window.location.host}/users/sign_in"
