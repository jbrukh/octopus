App.RecordingsNewRoute = Ember.Route.extend
  needs: ['participant_selector']

  model: () ->
    @transaction = @get('store').transaction()
    recording = @transaction.createRecord App.Recording

    # if we have a selected participant then assign them now
    currentParticipant = @controllerFor('participant_selector').get('model')
    recording.set('participant', currentParticipant) if currentParticipant
    recording

  setupController: (controller, params) ->
    controller.set 'duration', ''

  activate: ->
    controller = @controllerFor('recordings.new')
    settings = App.Settings.find()
    connector = @get('connector')

    # create and start a data adapter
    dataAdapter = App.DataAdapter.buildFromSettings(connector, settings)
    dataAdapter.start()
    controller.set 'dataAdapter', dataAdapter

  deactivate: ->
    # if we have are currently recording then just stop the
    # recording, we should probably prompt here.
    controller = @controllerFor('recordings.new')

    # if controller.get('model.isRecording') && !confirm('Are you sure you want to stop recording?')
    # somehow stop the transition from taking place

    controller.stop()

    @transaction.rollback() if @transaction

  events:
    endRecord: ->
      console.log 'End Record'
      @get('connector').send('record', {record: false}).then (data) =>
        console.debug 'end record received'
        @currentModel.finish(data)
        @send('upload')

    upload: ->
      authToken = @controllerFor('currentUser').get('authenticationToken')
      resourceId = @currentModel.get 'resourceId'

      @currentModel.one 'didCreate', =>
        console.debug 'created current model'

        # wait until the model has an id
        Ember.run.next this, =>
          recordingId = @currentModel.get('id')

          payload = {
            token: authToken,
            resource_id: resourceId,
            endpoint: "http://localhost:3000/api/recordings/#{recordingId}/results"
          }

          @get('connector').send('upload', payload).then (data) =>
            @transitionTo 'recordings.index'
            @transaction = null

      console.debug 'Commiting transaction'
      @transaction.commit()