App.VideosIndexController = Em.ArrayController.extend
  actions:
    destroy: (video) ->
      return unless confirm('Are you sure you want to delete this video?')
      video.deleteRecord()
