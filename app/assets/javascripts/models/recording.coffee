attr = Ember.attr
hasMany = Ember.hasMany
belongsTo = Ember.belongsTo

App.Recording = Ember.Model.extend App.Recordable,
  id:                   attr()

  participant:          belongsTo(App.Participant, { key: 'participant', embedded: true })
  taggings:             hasMany('App.Tagging', { key: 'taggings', embedded: true })

  createdAt:            attr(Date)
  updatedAt:            attr(Date)

  state:                attr()
  name:                 attr()
  description:          attr()
  owner:                attr()
  durationMs:           attr(Number)

  dataContentType:      attr()
  dataFileName:         attr()
  dataContentType:      attr()
  dataFileSize:         attr()
  dataUpdatedAt:        attr()
  dataUrl:              attr()

  isUploading: (->
    @get('state') == 'waiting_for_data'
  ).property('state')

App.Recording.url = "/api/recordings"
App.Recording.rootKey = 'recording'
App.Recording.collectionKey = 'recordings'
App.Recording.camelizeKeys = true
App.Recording.adapter = Ember.RESTAdapter.create()