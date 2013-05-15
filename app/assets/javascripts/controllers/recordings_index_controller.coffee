App.RecordingsIndexController = Em.ArrayController.extend
  sortProperties: ['createdAt']
  sortAscending:  false

  canRecord: (->
    @get('connector.isConnected')
  ).property('connector.isConnected')

  destroy: (recording) ->
    recording.deleteRecord();
    recording.get("transaction").commit()