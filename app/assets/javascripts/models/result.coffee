App.Result = Ember.Object.extend()

App.Result.reopenClass
  find: (recording, id) ->
    recordingId = recording.get('id')
    result = App.Result.create { id: id }
    $.ajax({
      dataType: "json",
      url: "/api/recordings/#{recordingId}/results",
    }).success (data) ->
      result.setProperties data.result
      result.set 'isLoaded', true
    result