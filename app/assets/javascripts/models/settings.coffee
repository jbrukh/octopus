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
        live: Em.Object.create
          url: 'ws://localhost:8000/device'
      graphs: Em.Object.create
        streaming: Em.Object.create
          bufferSize: 800
          duration: 10

  load: ->
    console.log 'Loading settings'
    record = @createRecord()
    settings = localStorage['octopus.settings']
    if settings
      console.debug ' - Loading stored settings'
      record.setProperties(JSON.parse(settings))
    record

  save: (settings) ->
    console.log 'Persisting settings'
    localStorage['octopus.settings'] = JSON.stringify(settings)
    @instance = settings
    settings