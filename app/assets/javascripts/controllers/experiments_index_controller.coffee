App.ExperimentsIndexController = Em.ArrayController.extend

  destroy: (experiment) ->
    if confirm 'Are you sure you want to delete this experiment'
      experiment.deleteRecord()
      @get('store').commit()