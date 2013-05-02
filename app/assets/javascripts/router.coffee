App.Router.map ->
  @resource 'experiments', -> null
  @resource 'experiment', ->
    @route 'start', { path: '/start/:theory_id' }

  @resource 'settings', -> null

  @resource 'videos', ->
    @route 'new'
  @route 'video', { path: '/video/:video_id' }

  @resource 'status', -> null
  @resource 'theories', ->
    @route 'new'

  @route 'theory', { path: '/theory/:theory_id' }