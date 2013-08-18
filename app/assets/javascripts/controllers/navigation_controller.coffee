App.NavigationController = Em.Controller.extend
  needs: ['currentUser']

  canNavigate: (->
    signedIn = @get('currentUser.isSignedIn')
    return false unless signedIn

    role = @get('currentUser.role')
    return role == 'admin'
  ).property('currentUser.isSignedIn', 'currentUser.role')

  signOut: ->
    url = "http://#{window.location.host}/users/sign_out"
    $.ajax
      url: url
      type: 'DELETE'
      success: (result) ->
        window.location = "http://#{window.location.host}"
