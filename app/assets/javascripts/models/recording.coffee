App.Recording = DS.Model.extend

  createdAt:   DS.attr 'date'
  updatedAt:   DS.attr 'date'

  state:        DS.attr 'string'

  start: ->
    @set 'isRecording', true

  finish: (response) ->
    @set 'isRecording', false
    @set 'resourceId', response.resource_id
    @set 'canUpload', true

  isUploading: (->
    @get('state') == 'waiting_for_data'
  ).property('state')

  result: (->
    resultId = @get('resultId')
    App.Result.find(this, resultId)
  ).property('resultId')