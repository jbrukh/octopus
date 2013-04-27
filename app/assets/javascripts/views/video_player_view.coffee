App.VideoPlayerView = Ember.View.extend
  templateName: 'shared/player'
  attributeBindings: 'src width height'.w()

  play: ->
    video.play();