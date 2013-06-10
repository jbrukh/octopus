App.TrialStartRoute = Em.Route.extend
  needs: ['currentParticipant']

  model: ->
    participant = @controllerFor('currentParticipant').get('model')

    experiment = this.modelFor("experiment")
    experiment.startTrial(participant)

  setupController: (controller, params) ->
    @_super(controller, params)

    settings = App.Settings.find()
    connector = @get('connector')
    controller.set 'dataAdapter', App.DataAdapter.buildFromSettings(connector, settings)