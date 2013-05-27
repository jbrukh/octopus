App.RecordingsNewController = Ember.Controller.extend Ember.Evented,
  needs: ['currentUser']

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
    payload.seconds = duration if duration > 0

    console.log 'start recording'
    @get('connector').send('record', payload).then =>
      @get('model').start()