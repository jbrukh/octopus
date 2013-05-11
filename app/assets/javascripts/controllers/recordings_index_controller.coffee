App.RecordingsIndexController = Em.ArrayController.extend
  sortProperties: ['createdAt']
  sortAscending:  false

  canRecord: (->
    @get('connector.isConnected')
  ).property('connector.isConnected')