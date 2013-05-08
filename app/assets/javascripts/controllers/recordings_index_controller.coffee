App.RecordingsIndexController = Em.ArrayController.extend
  canRecord: (->
    @get('connector.isConnected')
  ).property('connector.isConnected')