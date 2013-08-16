App.RecordingsLocalController = Em.ArrayController.extend App.RecordableList,
  sortProperties: ['lastModified']
  sortAscending:  false

  newRecordingRoute: (->
    'recordings.new.local'
  ).property()

  upload: (recording) ->
    authToken = @get 'currentUser.authenticationToken'
    connector = @get 'connector'

    recording = App.Recording.create
      'resourceId': recording.get('id')

    recording.save().then =>
      recording.upload(connector, authToken).then (data) =>
        @transitionToRoute 'recordings.cloud'