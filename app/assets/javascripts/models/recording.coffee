App.Recording = Em.Object.extend
  start: ->
    @set 'isRecording', true

  finish: (response) ->
    @set 'isRecording', false
    @set 'resource_id', response.resource_id
    @set 'canUpload', true