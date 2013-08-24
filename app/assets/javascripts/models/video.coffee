App.Video = App.Media.extend()

App.Video.url = "/api/videos"
App.Video.rootKey = 'video'
App.Video.collectionKey = 'videos'
App.Video.camelizeKeys = true
App.Video.adapter = App.MetaRESTAdapter.create()
