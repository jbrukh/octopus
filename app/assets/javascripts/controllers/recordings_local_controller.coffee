App.RecordingsLocalController = Em.ArrayController.extend App.RecordableList,
  sortProperties: ['lastModified']
  sortAscending:  false

  newRecordingRoute: (->
    'recordings.new.local'
  ).property()

  upload: (localRecording) ->
    uploader = @get('uploader')
    uploader.uploadLocal(localRecording).then =>
      @transitionToRoute 'recordings.cloud'