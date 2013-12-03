attr = DS.attr
belongsTo = DS.belongsTo

App.Experiment = DS.Model.extend
  media:        belongsTo('media')

  name:         attr()
  description:  attr()
  owner:        attr()
  created_at:   attr('date')
  updated_at:   attr('date')

  startTrial: (participant) ->
    return App.Trial.create
      state: 'setup'
      experiment: this

# App.Experiment.url = "/api/experiments"
# App.Experiment.rootKey = 'experiment'
# App.Experiment.collectionKey = 'experiments'
# App.Experiment.camelizeKeys = true
# App.Experiment.adapter = App.MetaRESTAdapter.create()
