App.CurrentParticipantController = Em.ObjectController.extend
  select: (participant) ->
    @set 'model', participant

  clear: ->
    @set 'model', null