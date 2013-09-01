App.ExperimentsIndexController = Em.ArrayController.extend
  canStartTrials: (->
    @get('connector.isConnected')
  ).property('connector.isConnected')

  actions:
    destroy: (experiment) ->
      if confirm('Are you sure you want to delete this experiment')
        experiment.deleteRecord()
        @get('store').commit()