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
          resolution: 50
          channels: 8

  load: ->
    console.log 'loading settings'
    @createRecord()

  save: (settings) ->
    @instance = settings
    settings