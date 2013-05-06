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
    console.log 'start recording'
    @get('connector').send('record', {record: true}).then =>
      @get('model').start()

  endRecord: ->
    console.log 'end recording'
    @get('connector').send('record', {record: false}).then (data) =>
      console.log data
      @get('model').finish(data)

  upload: ->
    token = @currentUser.get('authenticationToken')
    resourceId = @get 'model.resourceId'
    @get('connector').send('upload', {token: token, resource_id: resourceId}).then (data) =>
      console.log 'finished uploading'
      console.log data