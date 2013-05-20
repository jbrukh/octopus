App.ParticipantsIndexController = Em.ArrayController.extend
  destroy: (participant) ->
    participant.deleteRecord();
    participant.get("transaction").commit()