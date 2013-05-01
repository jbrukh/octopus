App.ExperimentsIndexController = Ember.Controller.extend Ember.Evented,
  start: ->
    console.log 'starting experiment'
    @set 'isRunning', true
    @get('dataAdapter').start()
    @trigger 'didStart'

  stop: ->
    console.log 'stopping experiment'
    @set 'isRunning', false
    isRecording = @get('isRecording')
    if isRecording
      @get('connector').send('record', {record: false}).then =>
        @get('dataAdapter').stop()
        @trigger 'didStop'
        @set 'isRecording', false
    else
      @get('dataAdapter').stop()
      @trigger 'didStop'

  record: ->
    console.log 'start recording'
    @get('connector').send('record', {record: true}).then =>
      @set 'isRecording', true