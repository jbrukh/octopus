App.ParticipantSelectorController = Em.ObjectController.extend
  select: (participant) ->
    @set 'model', participant