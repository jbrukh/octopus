attr = Ember.attr
hasMany = Ember.hasMany
belongsTo = Ember.belongsTo

App.Recording = Ember.Model.extend App.Recordable,
  id:                   attr()

  participant:          belongsTo(App.Participant, { key: 'participant', embedded: true })
  taggings:             hasMany('App.Tagging', { key: 'taggings', embedded: true })
  analyses:             hasMany('App.Analysis', { key: 'analyses', embedded: true })

  createdAt:            attr(Date)
  updatedAt:            attr(Date)

  state:                attr()
  name:                 attr()
  description:          attr()
  owner:                attr()
  durationMs:           attr(Number)

  attachment: (->
    return if @get('isUploading')
    id = @get 'id'
    App.RecordingAttachment.find(id)
  ).property('isUploading')

  isUploading: (->
    @get('state') == 'waiting_for_data'
  ).property('state')

  process: (algorithm) ->
    id = @get('id')

    payload = analysis:
      algorithm: algorithm

    $.post("/api/recordings/#{id}/analysis", payload).then (data) =>
      @get('analyses').create(data)

App.Recording.url = "/api/recordings"
App.Recording.rootKey = 'recording'
App.Recording.collectionKey = 'recordings'
App.Recording.camelizeKeys = true
App.Recording.adapter = App.MetaRESTAdapter.create()
