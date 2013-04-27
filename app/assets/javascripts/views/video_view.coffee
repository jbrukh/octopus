App.VideoView = Ember.View.extend
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

  loadMetaData: ->
    console.log "loading video meta data"
    @set 'ready', true
    @set 'supportsFullscreen', true if this.$video.webkitSupportsFullscreen

  fullscreen: ->
    this.$video.webkitEnterFullScreen()

  play: ->
    this.$video.play()
    @set 'isPlaying', true

  pause: ->
    this.$video.pause()
    @set 'isPlaying', false