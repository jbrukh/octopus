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

  attachment: (->
    id = @get 'id'
    App.RecordingAttachment.find(id)
  ).property()

  policy: (->
    id = @get 'id'
    App.Policy.find(id)
  )

  isUploading: (->
    @get('state') == 'waiting_for_data'
  ).property('state')

App.Recording.url = "/api/recordings"
App.Recording.rootKey = 'recording'
App.Recording.collectionKey = 'recordings'
App.Recording.camelizeKeys = true
App.Recording.adapter = Ember.RESTAdapter.create()