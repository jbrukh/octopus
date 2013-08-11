App.RecordingsCloudController = Em.ArrayController.extend App.RecordableList,
  sortProperties: ['createdAt']
  sortAscending:  false

  newRecordingRoute: (->
    'recordings.new.cloud'
  ).property()