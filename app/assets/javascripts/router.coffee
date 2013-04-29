App.Router.map ->
  @resource 'experiments', -> null
  @resource 'settings', -> null
  @resource 'videos', -> null

  @resource 'status', -> null
  @resource 'theories', ->
    @route 'new'

  @route 'theory', { path: '/theory/:theory_id' }