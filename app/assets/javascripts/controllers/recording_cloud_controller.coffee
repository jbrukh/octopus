App.RecordingCloudController = Em.ObjectController.extend App.RecordableShow,
  save: ->
    model = @get 'model'

    model.set 'name', @get('newName')
    model.set 'description', @get('newDescription')
    model.save().then =>
      @send('close')

  createTag: ->
    console.log 'create tag'
    tagging = @get 'tagging'
    tagging.set('recording', @get('model'))
    tagging.save()

  recordingData: (->
    return unless @get 'model.attachment.isLoaded'
    url = @get 'model.attachment.dataUrl'

    console.info "Loading result data: #{url}"
    resultData = App.RecordingData.create()

    xhr = new XMLHttpRequest()
    xhr.open 'GET', url, true
    xhr.responseType = 'arraybuffer'

    xhr.onload = (e) =>
      resultData.populateFromArrayBuffer xhr.response
    xhr.send()

    resultData
  ).property('model.attachment.isLoaded')