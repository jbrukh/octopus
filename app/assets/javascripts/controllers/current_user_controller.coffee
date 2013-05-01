App.CurrentUserController = Em.ObjectController.extend
  isSignedIn: (->
    @get('content') != null
  ).property('content')