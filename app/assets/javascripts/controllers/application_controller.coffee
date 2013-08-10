App.ApplicationController = Ember.Controller.extend
  goToSignIn: ->
    console.log 'going to sign in'
    window.location = "http://#{window.location.host}/users/sign_in"

  routeChanged: (->
    Em.run.next ->
      analytics.track_pageview(window.location.href)
  ).observes('currentPath')
