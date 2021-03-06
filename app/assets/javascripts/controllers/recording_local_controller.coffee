App.RecordingLocalController = Em.ObjectController.extend App.RecordableShow,
  recordingData: (->
    resourceId = @get 'model.id'
    resultData = App.RecordingData.create()

    connector = @get 'connector'
    connector.send('repository', { operation: 'get', resource_id: resourceId, local: true }).then (data) =>
      resultData.populateFromDataView data

    resultData
  ).property('model')

  actions:
    upload: ->
      uploader = @get('uploader')
      localRecording = @get('model')
      uploader.uploadLocal(localRecording).then =>
        @transitionToRoute 'recordings.cloud'