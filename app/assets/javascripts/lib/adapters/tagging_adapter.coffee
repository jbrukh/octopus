App.TaggingAdapter = Ember.RESTAdapter.extend

  createRecord: (record) ->
    recordingId = record.get('recording.id')
    url = "/api/recordings/#{recordingId}/taggings"
    debugger
    this.ajax(url, record.toJSON(), "POST").then (data) =>
      @didCreateRecord record, data