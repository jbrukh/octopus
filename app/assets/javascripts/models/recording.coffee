attr = Ember.attr
hasMany = Ember.hasMany
belongsTo = Ember.belongsTo

App.Recording = Ember.Model.extend

  participant:          belongsTo 'App.Participant', { key: 'partcipant', embedded: true }

  createdAt:            attr(Date)
  updatedAt:            attr(Date)

  state:                attr()
  name:                 attr()
  description:          attr()
  owner:                attr()
  durationMs:           attr(Number)

  dataContentType:      attr()
  dataFileName:         attr()
  dataContentType:      attr()
  dataFileSize:         attr()
  dataUpdatedAt:        attr()
  dataUrl:              attr()

  start: ->
    @set 'isRecording', true

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

App.Recording.url = "/api/recordings"
App.Recording.rootKey = 'recording'
App.Recording.collectionKey = 'recordings'
App.Recording.camelizeKeys = true
App.Recording.adapter = Ember.RESTAdapter.create()