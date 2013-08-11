App.RecordingLocalController = Em.ObjectController.extend
  recordingData: (->
    resourceId = @get 'model.id'
    resultData = App.RecordingData.create()

    connector = @get 'connector'
    connector.send('repository', { operation: 'get', resource_id: resourceId }).then (data) =>
      resultData.populateFromDataView data

    resultData
  ).property('model')