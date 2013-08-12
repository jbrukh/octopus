App.RecordingsNewCloudRoute = Ember.Route.extend
  needs: ['currentParticipant']

  model: () ->
    recording = App.Recording.create()

    # if we have a selected participant then assign them now
    currentParticipant = @controllerFor('currentParticipant').get('model')
    recording.set('participant', currentParticipant) if currentParticipant
    recording

  setupController: (controller, model) ->
    @_super(controller, model)
    controller.set 'duration', ''

  activate: ->
    controller = @controllerFor('recordings.new.cloud')

    # reset properties
    controller.set('lastTransition', null)
    controller.set('confirmTransition', false)

    settings = App.Settings.find()
    connector = @get('connector')

    # create and start a data adapter
    dataAdapter = App.DataAdapter.buildFromSettings(connector, settings)
    dataAdapter.start()
    controller.set 'dataAdapter', dataAdapter

  deactivate: ->
    # if we have are currently recording then just stop the recording
    controller = @controllerFor('recordings.new.cloud')
    controller.stop()

  events:
    retryEndRecord: ->
      controller = @controllerFor('recordings.new.cloud')
      transition = controller.get('lastTransition')
      transition.retry()

    willTransition: (transition) ->
      controller = @controllerFor('recordings.new.cloud')
      # if we're not recording or we've previously confirmed the ability
      # to transition then let the transition through
      return if controller.get('confirmTransition')
      return unless controller.get('model.isRecording')

      console.log 'Currently recording, showing confirm transition message'
      controller.set('confirmTransition', true)
      controller.set('lastTransition', transition)
      transition.abort()

    endRecord: ->
      console.log 'End Record'
      @get('connector').send('record', {record: false}).then (data) =>
        console.debug 'end record received'
        analytics.track 'create recording', { location: 'cloud', type: 'manual' }
        @currentModel.finish(data)
        @send('upload')

    upload: ->
      authToken = @controllerFor('currentUser').get('authenticationToken')
      resourceId = @currentModel.get 'resourceId'

      @currentModel.save().then =>
        recordingId = @currentModel.get('id')

        payload = {
          token: authToken,
          resource_id: resourceId,
          endpoint: "http://localhost:3000/api/recordings/#{recordingId}/results"
        }

        @get('connector').send('upload', payload).then (data) =>
          @transitionTo 'recordings.cloud'
