App.VideoPlayerView = Ember.View.extend Ember.Evented,
  templateName: 'shared/player'
  attributeBindings: 'src width height'.w()

  play: ->
    @trigger 'onPlay'

  fullscreen: ->
    @trigger 'onFullscren'

  pause: ->
    @trigger 'onPause'