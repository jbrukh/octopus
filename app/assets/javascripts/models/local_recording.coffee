attr = Ember.attr
hasMany = Ember.hasMany
belongsTo = Ember.belongsTo

App.LocalRecording = Ember.Model.extend
  id: attr()
  file: attr()
  lastModified: attr(UnixDate)
  sizeBytes: attr()

  start: ->
    @set 'isRecording', true

  finish: (response) ->
    @set 'isRecording', false
    @set 'resourceId', response.resource_id

App.LocalRecording.camelizeKeys = true
App.LocalRecording.adapter = App.ConnectorAdapter.create()
App.LocalRecording.collectionKey = 'resource_infos'