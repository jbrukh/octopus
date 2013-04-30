App.Router.map ->
  @resource 'experiments', -> null
  @resource 'settings', -> null

  @resource 'videos', ->
    @route 'new'
  @route 'video', { path: '/video/:video_id' }

  @resource 'status', -> null
  @resource 'theories', ->
    @route 'new'

  @route 'theory', { path: '/theory/:theory_id' }