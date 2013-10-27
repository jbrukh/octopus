App.NavigationController = Em.Controller.extend
  needs: ['currentUser']

  canNavigate: (->
    return @get('currentUser.isSignedIn')
  ).property('currentUser.isSignedIn')

  actions:
    signOut: ->
      url = "http://#{window.location.host}/users/sign_out"
      $.ajax
        url: url
        type: 'DELETE'
        success: (result) ->
          window.location = "http://#{window.location.host}"
