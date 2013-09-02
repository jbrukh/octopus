App.VideosIndexController = Em.ArrayController.extend
  actions:
    destroy: (video) ->
      video.deleteRecord();
      video.get("transaction").commit()