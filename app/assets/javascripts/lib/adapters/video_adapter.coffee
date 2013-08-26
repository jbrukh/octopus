App.VideoAdapter = Ember.RESTAdapter.extend
  createRecord: (record) ->
    name = record.get 'name'
    attachment = record.get 'attachment'
    console.log attachment
    debugger