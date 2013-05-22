App.VideosIndexController = Em.ArrayController.extend
  destroy: (video) ->
    video.deleteRecord();
    video.get("transaction").commit()