App.RecordingCloudController = Em.ObjectController.extend
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
    dataUrl = @get 'dataUrl'
    console.info "Loading result data: #{dataUrl}"
    resultData = App.RecordingData.create()

    xhr = new XMLHttpRequest()
    xhr.open 'GET', dataUrl, true
    xhr.responseType = 'arraybuffer'

    xhr.onload = (e) =>
      resultData.populateFromArrayBuffer xhr.response
    xhr.send()

    resultData
  ).property('model.dataUrl')