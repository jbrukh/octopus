App.Recording = DS.Model.extend

  created_at:   DS.attr 'date'
  updated_at:   DS.attr 'date'

  state:        DS.attr 'string'

  start: ->
    @set 'isRecording', true

  finish: (response) ->
    @set 'isRecording', false
    @set 'resourceId', response.resource_id
    @set 'canUpload', true