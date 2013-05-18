App.NavigationController = Em.Controller.extend
  needs: ['currentUser']

  canNavigate: (->
    signedIn = @get('currentUser.isSignedIn')
    return false unless signedIn

    role = @get('currentUser.role')
    return role == 'admin'
  ).property('currentUser.isSignedIn', 'currentUser.role')