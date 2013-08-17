App.RecordingsLocalController = Em.ArrayController.extend App.RecordableList,
  sortProperties: ['lastModified']
  sortAscending:  false

  newRecordingRoute: (->
    'recordings.new.local'
  ).property()

  upload: (recording) ->
    recording = App.Recording.create
      'resourceId': recording.get('id')

    recording.save().then =>
      @get('uploader').upload(recording).then (data) =>
        @transitionToRoute 'recordings.cloud'