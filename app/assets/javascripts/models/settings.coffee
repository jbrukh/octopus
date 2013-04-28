App.Settings = Em.Object.extend
  save: ->
    result = Ember.Deferred.create()
    if(App.Settings.save(this))
      result.resolve()
    else
      result.reject()
    result

App.Settings.reopenClass
  instance: null

  find: ->
    @instance = @load() unless @instance
    @instance

  createRecord: ->
    App.Settings.create
      adapters: Em.Object.create
        selected: 'mock'
        mock: Em.Object.create
          resolution: 10
          channels: 8
        live: Em.Object.create
          url: 'ws://localhost:8000/device'
      graphs: Em.Object.create
        streaming: Em.Object.create
          bufferSize: 800
          duration: 10

  load: ->
    console.log 'loading settings'
    record = @createRecord()
    settings = localStorage['octopus.settings']
    if settings
      console.log ' - loading stored settings'
      record.setProperties(JSON.parse(settings))
    record

  save: (settings) ->
    localStorage['octopus.settings'] = JSON.stringify(settings)
    @instance = settings
    settings