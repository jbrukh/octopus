App.Router.map ->
  @resource 'experiments', -> null
  @resource 'settings', -> null

  @resource 'media', -> null
  @resource 'videos', ->
    @route 'new'

  @resource 'status', -> null
  @resource 'theories', ->
    @route 'new'

  @route 'theory', { path: '/theory/:theory_id' }