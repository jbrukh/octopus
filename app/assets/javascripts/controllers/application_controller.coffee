App.ApplicationController = Ember.Controller.extend
  goToSignIn: ->
    console.log 'going to sign in'
    window.location = "http://#{window.location.host}/users/sign_in"

  routeChanged: (->
    console.log 'route changed'
    return unless App.Environment == 'production'
    Em.run.next ->
      console.log 'tracking pageview'
      mixpanel.track_pageview()
  ).observes('currentPath')
