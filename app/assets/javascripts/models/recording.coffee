App.Recording = DS.Model.extend

  participant:          DS.belongsTo('App.Participant')

  createdAt:            DS.attr 'date'
  updatedAt:            DS.attr 'date'

  state:                DS.attr 'string'
  sessionId:            DS.attr 'string'
  name:                 DS.attr 'string'
  description:          DS.attr 'string'
  owner:                DS.attr 'string'
  durationMs:           DS.attr 'number'

  dataContentType:      DS.attr 'string'
  dataFileName:         DS.attr 'string'
  dataContentType:      DS.attr 'string'
  dataFileSize:         DS.attr 'string'
  dataUpdatedAt:        DS.attr 'string'
  dataUrl:              DS.attr 'string'

  start: (session_id) ->
    @set 'isRecording', true
    @set 'sessionId', session_id

  finish: (response) ->
    @set 'isRecording', false
    @set 'resourceId', response.resource_id

  isUploading: (->
    @get('state') == 'waiting_for_data'
  ).property('state')

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
  ).property('dataUrl')