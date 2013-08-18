App.RecordingsCloudController = Em.ArrayController.extend App.RecordableList, App.Pageable,
  sortProperties: ['createdAt']
  sortAscending:  false

  newRecordingRoute: (->
    'recordings.new.cloud'
  ).property()

  pageRoute: (->
    return 'recordings.cloud.page'
  ).property()
