App.RecordingsCloudController = Em.ArrayController.extend App.RecordableController,
  sortProperties: ['createdAt']
  sortAscending:  false

  newRecordingRoute: (->
    'recordings.new.cloud'
  ).property()