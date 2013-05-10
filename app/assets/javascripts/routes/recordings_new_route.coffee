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
    # if we have are currently recording then just stop the
    # recording, we should probably prompt here.
    controller = @controllerFor('recordings.new')
    controller.stop()

    @transaction.rollback() if @transaction

  events:
    upload: ->
      token = @controllerFor('currentUser').get('authenticationToken')
      resourceId = @currentModel.get 'resourceId'

      @currentModel.one 'didCreate', =>
        # wait until the model has an id
        Ember.run.next this, =>
          recordingId = @currentModel.get('id')
          endpoint = "http://localhost:3000/api/recordings/#{recordingId}/results"
          @get('connector').send('upload', {token: token, resource_id: resourceId, endpoint: endpoint}).then (data) =>
            @transitionTo 'recordings.index'
            @transaction = null
      @transaction.commit()