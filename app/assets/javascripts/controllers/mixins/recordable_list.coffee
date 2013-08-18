App.RecordableList = Ember.Mixin.create
  canRecord: (->
    @get('connector.isConnected')
  ).property('connector.isConnected')

  destroy: (recording) ->
    if confirm('Are you sure you want to delete this recording')
      recording.deleteRecord()

      # we need to call remove object here because the contents might be
      # created using a findQuery and deleteRecord will only remove the
      # object from the findAll record array
      @get('model').removeObject(recording)
