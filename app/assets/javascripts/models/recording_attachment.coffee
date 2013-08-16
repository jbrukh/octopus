attr = Ember.attr
belongsTo = Ember.belongsTo

App.RecordingAttachment = Em.Model.extend
  id:                   attr()
  dataContentType:      attr()
  dataFileName:         attr()
  dataContentType:      attr()
  dataFileSize:         attr()
  dataUpdatedAt:        attr()
  dataUrl:              attr()

App.RecordingAttachment.rootKey = 'result'
App.RecordingAttachment.collectionKey = 'results'
App.RecordingAttachment.camelizeKeys = true
App.RecordingAttachment.adapter = App.RecordingAttachmentAdapter.create()