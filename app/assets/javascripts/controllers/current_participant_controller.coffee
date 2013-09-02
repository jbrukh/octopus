App.CurrentParticipantController = Em.ObjectController.extend
  actions:
    select: (participant) ->
      @set 'model', participant

    clear: ->
      @set 'model', null