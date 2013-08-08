App.RecordingLocalController = Em.ObjectController.extend

  recordingData: (->
    resourceId = @get 'model.id'
    resultData = App.RecordingData.create()

    console.log 'before load'

    connector = @get 'connector'
    connector.send('repository', { operation: 'get', resource_id: resourceId }, 'binary').then (data) =>
      console.log data

    #resultData.populateFromArrayBuffer xhr.response

    resultData
  ).property('model')