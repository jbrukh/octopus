attr = Ember.attr
hasMany = Ember.hasMany
belongsTo = Ember.belongsTo

App.LocalRecording = Ember.Model.extend
  resourceId: attr()
  file: attr()
  lastModified: attr()
  sizeBytes: attr()

App.LocalRecording.camelizeKeys = true
App.LocalRecording.adapter = App.ConnectorAdapter.create()
App.LocalRecording.collectionKey = 'resource_infos'
App.LocalRecording.primaryKey = 'resourceId';