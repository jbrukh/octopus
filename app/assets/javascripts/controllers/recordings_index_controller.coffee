App.RecordingsIndexController = Em.Controller.extend
  canRecord: (->
    @get('connector.isConnected')
  ).property('connector.isConnected')