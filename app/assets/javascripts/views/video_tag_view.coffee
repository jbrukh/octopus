App.VideoTagView = Ember.View.extend
  tagName: 'video'
  preload: "metadata"
  attributeBindings: 'src controls width height preload'.w()

  $video: null

  didInsertElement: ->
    @set 'ready', false
    @set 'supportsFullscreen', false
    @set 'isPlaying', false

    this.$video = this.$()[0]

    if (this.$video.readyState > 0)
      @loadMetaData()
    else
      this.$().on 'loadedmetadata', () => @loadMetaData()

    this.$().on 'ended', =>
      console.log 'video ended'
      @set 'isPlaying', false

    this.$().on 'timeupdate', =>
      @set 'progress', this.$video.currentTime

    remote = @get 'remote'
    return unless remote
    remote.on 'onPlay', () => @play()
    remote.on 'onPause', () => @pause()
    remote.on 'onFullscreen', () => @fullscreen()

  willDestroyElement: ->
    remote = @get 'remote'
    return unless remote
    remote.off 'onPlay'
    remote.off 'onPause'
    remote.off 'onFullscreen'

  loadMetaData: ->
    console.log "loading video meta data"
    @set 'ready', true
    @set 'supportsFullscreen', true if this.$video.webkitSupportsFullscreen
    @set 'duration', this.$video.duration

  fullscreen: ->
    this.$video.webkitEnterFullScreen()

  play: ->
    this.$video.play()
    @set 'isPlaying', true

  pause: ->
    this.$video.pause()
    @set 'isPlaying', false

  progressPercentage: (->
    return @get('progress') / @get('duration')
  ).property('progress', 'duration')