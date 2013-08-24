App.Router.map ->
  @resource 'status', -> null

  # participants
  @resource 'participants', ->
    @route 'new'
    @route 'page', { path: 'page/:page_id' }

  @resource 'participant', { path: '/participant/:participant_id' }

  #experiments
  @resource 'experiments', ->
    @route 'new'

  @resource 'experiment', { path: '/experiment/:experiment_id' }, ->
    @resource 'trial', ->
      @route 'start', { path: '/start' }

  # recordings
  @resource 'recordings', ->
    @route 'new.cloud', { path: '/new/cloud' }
    @route 'new.local', { path: '/new/local' }
    @route 'cloud'
    @route 'cloud.page', { path: '/cloud/page/:page_id' }
    @route 'local'

  @resource 'recording.cloud', { path: '/recording/cloud/:recording_id' }
  @resource 'recording.local', { path: '/recording/local/:local_recording_id' }

  # media
  @resource 'videos', ->
    @route 'new'

  @resource 'video', ->
    @route 'index', { path: '/:video_id' }

  @resource 'slideshows', ->
    @route 'new'

  @resource 'slideshow', { path: '/slideshow/:slideshow_id' }

  @resource 'audios', ->
    @route 'new'

  @resource 'audio', { path: '/audio/:audio_id' }

  @route 'missing', { path: '*:' }