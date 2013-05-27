App.RecordingsNewController = Ember.Controller.extend Ember.Evented,
  duration: null

  start: ->
    console.log 'starting experiment'
    @get('dataAdapter').start()

  stop: ->
    console.log 'stopping experiment'
    @set 'isRunning', false
    isRecording = @get('model.isRecording')
    if isRecording
      @get('connector').send('record', {record: false}).then (data) =>
        @get('dataAdapter').stop()
        @trigger 'didStop'
        @get('model').stop(data)
    else
      @get('dataAdapter').stop()
      @trigger 'didStop'

  beginRecord: ->
    payload = { record: true }

    duration = parseInt @get('duration')
    if duration > 0
      console.log "Beginning timed recording of #{duration} seconds"
      payload.seconds = duration

    connector = @get 'connector'

    console.log 'start recording'
    connector.send('record', payload).then (d) =>
      @get('model').start()

      connector.next(d).then (r) =>
        console.log 'timed recording finished'
        # do something here to stop and upload the timed recording