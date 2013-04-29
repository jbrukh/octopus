App.Router.map ->
  @resource 'experiments', -> null
  @resource 'settings', -> null
  @resource 'videos', -> null

  @resource 'status', -> null
  @resource 'theories', ->
    @route 'new'

  @resource 'theory', { path: '/theory/:theory_id' }, -> null