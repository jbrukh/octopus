App.RecordingsNewLocalRoute = Ember.Route.extend
  model: () ->
    recording = App.LocalRecording.create()

  setupController: (controller, model) ->
    @_super(controller, model)
    controller.set 'duration', ''

  activate: ->
    controller = @controllerFor('recordings.new.local')
    settings = App.Settings.find()
    connector = @get('connector')

    # create and start a data adapter
    dataAdapter = App.DataAdapter.buildFromSettings(connector, settings)
    dataAdapter.start()
    controller.set 'dataAdapter', dataAdapter

  deactivate: ->
    # if we have are currently recording then just stop the recording
    controller = @controllerFor('recordings.new.local')
    controller.stop()

  events:
    willTransition: (transition) ->
      controller = @controllerFor('recordings.new.local')
      if controller.get('model.isRecording') && !confirm('Are you sure you want to stop recording?')
        transition.abort()

    endRecord: ->
      console.log 'End Record'
      @get('connector').send('record', {record: false}).then (data) =>
        console.debug 'end record received'
        @currentModel.finish(data)
        @send('upload')

    upload: ->
      @transitionTo 'recordings.local'