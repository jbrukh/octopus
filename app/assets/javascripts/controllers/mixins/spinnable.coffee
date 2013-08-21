App.Spinnable = Ember.Mixin.create

  observeLoading: (->
    isLoading = @get('content.isLoading')
    if isLoading
      NProgress.start()
    else
      NProgress.done()
  ).observes('content.isLoading')