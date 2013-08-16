App.RecordingLocalController = Em.ObjectController.extend App.RecordableShow,
  recordingData: (->
    resourceId = @get 'model.id'
    resultData = App.RecordingData.create()

    connector = @get 'connector'
    connector.send('repository', { operation: 'get', resource_id: resourceId, local: true }).then (data) =>
      resultData.populateFromDataView data

    resultData
  ).property('model')

  upload: ->
    resourceId = @get('model.id')
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