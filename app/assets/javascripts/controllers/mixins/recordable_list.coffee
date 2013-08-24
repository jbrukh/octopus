App.RecordableList = Ember.Mixin.create
  canRecord: (->
    @get('connector.isConnected')
  ).property('connector.isConnected')

  destroy: (recording, shouldConfirm = true) ->
    if shouldConfirm
      return unless confirm('Are you sure you want to delete this recording')

    console.log 'here'
    recording.deleteRecord()

    # we need to call remove object here because the contents might be
    # created using a findQuery and deleteRecord will only remove the
    # object from the findAll record array
    @get('model').removeObject(recording)
