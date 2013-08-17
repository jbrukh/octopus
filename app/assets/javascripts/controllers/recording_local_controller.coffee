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
    recording = App.Recording.create
      'resourceId': @get('model.id')

    recording.save().then =>
      @get('uploader').upload(recording).then (data) =>
        @transitionToRoute 'recordings.cloud'