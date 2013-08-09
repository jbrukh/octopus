App.RecordingsNewController = Ember.Controller.extend Ember.Evented,
  duration: null

  start: ->
    console.log 'starting recording'
    @get('dataAdapter').start()

  stop: ->
    console.log 'stopping recording'
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

      # if we have a duration, then prepare to get another
      # message in this correlated message chain
      if duration > 0
        connector.next(d).then (data) =>
          @get('model').finish(data)
          @send('upload')