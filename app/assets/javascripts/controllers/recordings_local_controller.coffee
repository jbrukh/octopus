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