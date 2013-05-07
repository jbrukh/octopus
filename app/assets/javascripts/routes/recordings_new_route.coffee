App.RecordingsNewRoute = Ember.Route.extend
  model: () ->
    @transaction = @get('store').transaction()
    return @transaction.createRecord App.Recording

  activate: ->
    controller = @controllerFor('recordings.new')
    settings = App.Settings.find()
    connector = @get('connector')
    controller.set 'dataAdapter', App.DataAdapter.buildFromSettings(connector, settings)

  deactivate: ->
    @transaction.rollback() if @transaction

  events:
    upload: ->
      console.log 'uploading recording'
      token = @get('currentUser.authenticationToken')
      resourceId = @get 'model.resourceId'

      @currentModel.on 'didCreate', =>
        console.log 'did create recording'
        @transitionTo 'recordings.index'
        @transaction = null
      @transaction.commit()

      #@get('connector').send('upload', {token: token, resource_id: resourceId}).then (data) =>
      #  console.log 'finished uploading'
      #  console.log data