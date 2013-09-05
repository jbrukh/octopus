App.CurrentParticipantController = Em.ObjectController.extend
  select: (participant) ->
    @set 'model', participant

  actions:
    clear: ->
      @set 'model', null