App.Router.map ->
  @resource 'settings', -> null
  @resource 'status', -> null

  @resource 'participants', ->
    @route 'new'
  @route 'participant', { path: '/participant/:participant_id' }

  @resource 'trials', -> null
  @resource 'trial', ->
    @route 'start', { path: '/start/:experiment_id' }

  @resource 'experiments', ->
    @route 'new'
  @route 'experiment', { path: '/experiment/:experiment_id' }

  @resource 'recordings', ->
    @route 'new'
  @resource 'recording', { path: '/recording/:recording_id' }

  # media
  @resource 'videos', ->
    @route 'new'
  @route 'video', { path: '/video/:video_id' }

  @resource 'slideshows', ->
    @route 'new'
  @route 'slideshow', { path: '/slideshow/:slideshow_id' }
