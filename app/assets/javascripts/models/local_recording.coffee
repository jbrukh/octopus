attr = Ember.attr
hasMany = Ember.hasMany
belongsTo = Ember.belongsTo

App.LocalRecording = Ember.Model.extend
  id: attr()
  file: attr()
  lastModified: attr(UnixDate)
  sizeBytes: attr()

App.LocalRecording.camelizeKeys = true
App.LocalRecording.adapter = App.ConnectorAdapter.create()
App.LocalRecording.collectionKey = 'resource_infos'