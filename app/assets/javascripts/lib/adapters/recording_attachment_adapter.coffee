App.RecordingAttachmentAdapter = Ember.RESTAdapter.extend

  find: (record, id) ->
    recordingId = record.get('id')
    url = "/api/recordings/#{recordingId}/results"

    this.ajax(url).then (data) =>
      @didFind(record, id, data)
      record
