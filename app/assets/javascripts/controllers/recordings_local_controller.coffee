App.RecordingsLocalController = Em.ArrayController.extend App.RecordableList,
  sortProperties: ['lastModified']
  sortAscending:  false

  newRecordingRoute: (->
    'recordings.new.local'
  ).property()

  upload: (recording) ->
    resourceId = recording.get('id')
    recording = App.Recording.create
      'resourceId': resourceId

    authToken = @get('currentUser.authenticationToken')

    recording.save().then =>
      recordingId = recording.get('id')

      payload = {
        token: authToken,
        resource_id: resourceId,
        endpoint: "http://localhost:3000/api/recordings/#{recordingId}/results",
        local: true
      }

      @get('connector').send('upload', payload).then (data) =>
        @transitionToRoute 'recordings.cloud'