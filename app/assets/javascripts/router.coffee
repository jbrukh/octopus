App.Router.map ->
  @resource 'settings', -> null
  @resource 'status', -> null

  # participants
  @resource 'participants', ->
    @route 'new'

  @resource 'participant', { path: '/participant/:participant_id' }

  #experiments
  @resource 'experiments', ->
    @route 'new'

  @resource 'experiment', { path: '/experiment/:experiment_id' }, ->
    @resource 'trial', ->
      @route 'start', { path: '/start' }

  # recordings
  @resource 'recordings', ->
    @route 'new'

  @resource 'recording', { path: '/recording/:recording_id' }

  # media
  @resource 'videos', ->
    @route 'new'

  @resource 'video', ->
    @route 'index', { path: '/:video_id' }

  @resource 'slideshows', ->
    @route 'new'

  @resource 'slideshow', { path: '/slideshow/:slideshow_id' }
