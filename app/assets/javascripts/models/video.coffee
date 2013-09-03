attr = Ember.attr

App.Video = App.Media.extend
  dataUrl: attr()

App.Video.url = "/api/videos"
App.Video.rootKey = 'video'
App.Video.collectionKey = 'videos'
App.Video.camelizeKeys = true
App.Video.adapter = App.VideoAdapter.create()
