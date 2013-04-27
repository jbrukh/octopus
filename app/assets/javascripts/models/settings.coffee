App.Settings = Em.Object.extend
  save: ->
    d = Ember.Deferred.create()
    d.resolve(App.Settings.save(this))
    d

App.Settings.reopenClass
  instance: null

  find: ->
    @instance = @load() unless @instance
    @instance

  createRecord: ->
    App.Settings.create
      adapters: Em.Object.create
        mock: Em.Object.create
          resolution: 10
          channels: 8
      graphs: Em.Object.create
        streaming: Em.Object.create
          bufferSize: 800
          duration: 10

  load: ->
    console.log 'loading settings'
    @createRecord()

  save: (settings) ->
    @instance = settings
    settings