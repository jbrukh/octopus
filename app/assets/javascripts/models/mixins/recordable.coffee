App.Recordable = Ember.Mixin.create
  start: ->
    @set 'isRecording', true

  finish: (response) ->
    @set 'isRecording', false
    @set 'resourceId', response.resource_id
    @set 'durationMs', response.milliseconds
