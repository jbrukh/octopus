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

  isUploading: (->
    @get('state') == 'waiting_for_data'
  ).property('state')

  location: (->
    'cloud'
  ).property()

  upload: (connector, authToken) ->
    id = @get 'id'
    resourceId = @get 'resourceId'

    # calculate the current host name
    arr = window.location.href.split("/")
    rootPath = arr[0] + "//" + arr[2]

    payload = {
      token: authToken,
      resource_id: resourceId,
      endpoint: "#{rootPath}/api/results/#{id}",
      local: true
    }

    connector.send('upload', payload)

App.Recording.url = "/api/recordings"
App.Recording.rootKey = 'recording'
App.Recording.collectionKey = 'recordings'
App.Recording.camelizeKeys = true
App.Recording.adapter = Ember.RESTAdapter.create()