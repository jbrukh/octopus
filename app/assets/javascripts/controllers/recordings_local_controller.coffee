App.RecordingsLocalController = Em.ArrayController.extend App.RecordableList, App.Spinnable,
  sortProperties: ['lastModified']
  sortAscending:  false

  newRecordingRoute: (->
    'recordings.new.local'
  ).property()

  upload: (localRecording) ->
    uploader = @get('uploader')
    uploader.uploadLocal(localRecording).then =>
      @transitionToRoute 'recordings.cloud'