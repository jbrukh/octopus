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

  exportAsCsv: ->
    console.log 'Exporting as CSV'
    recordingData = @get 'recordingData'
    blob = new Blob [recordingData.exportAsCsv()], {type: 'text/csv'}
    id = @get 'model.id'
    saveAs(blob, "octopus_#{id}.csv");

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