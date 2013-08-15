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

      # calculate the current host name
      arr = window.location.href.split("/")
      result = arr[0] + "//" + arr[2]

      payload = {
        token: authToken,
        resource_id: resourceId,
        endpoint: "#{result}/api/recordings/#{recordingId}/results",
        local: true
      }

      @get('connector').send('upload', payload).then (data) =>
        @transitionToRoute 'recordings.cloud'