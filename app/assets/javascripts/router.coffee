App.Router.map ->
  @resource 'settings', -> null
  @resource 'status', -> null

  @resource 'trials', -> null
  @resource 'trial', ->
    @route 'start', { path: '/start/:theory_id' }

  @resource 'theories', ->
    @route 'new'
  @route 'theory', { path: '/theory/:theory_id' }

  @resource 'recordings', ->
    @route 'new'

  # media
  @resource 'videos', ->
    @route 'new'
  @route 'video', { path: '/video/:video_id' }

  @resource 'slideshows', ->
    @route 'new'
  @route 'slideshow', { path: '/slideshow/:slideshow_id' }
