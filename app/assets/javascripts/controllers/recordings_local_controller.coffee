App.RecordingsLocalController = Em.ArrayController.extend
  sortProperties: ['lastModified']
  sortAscending:  false

  canRecord: (->
    @get('connector.isConnected')
  ).property('connector.isConnected')

  destroy: (recording) ->
    recording.deleteRecord()

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
        endpoint: "http://localhost:3000/api/recordings/#{recordingId}/results"
      }

      @get('connector').send('upload', payload).then (data) =>
        @transitionToRoute 'recordings.cloud'