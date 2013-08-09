App.ApplicationController = Ember.Controller.extend
  goToSignIn: ->
    console.log 'going to sign in'
    window.location = "http://#{window.location.host}/users/sign_in"

  routeChanged: (->
    return unless App.Environment == 'production'
    Em.run.next ->
      mixpanel.track_pageview()
  ).observes('currentPath')
