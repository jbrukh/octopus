App.RecordableController = Ember.Mixin.create
  canRecord: (->
    @get('connector.isConnected')
  ).property('connector.isConnected')

  destroy: (recording) ->
    recording.deleteRecord()