attr = Ember.attr
belongsTo = Ember.belongsTo

App.Experiment = Ember.Model.extend
  media:        belongsTo('App.Media')

  name:         attr()
  description:  attr()
  owner:        attr()
  created_at:   attr(Date)
  updated_at:   attr(Date)

  startTrial: (participant) ->
    return App.Trial.create
      state: 'setup'
      experiment: this

App.Experiment.url = "/api/experiments"
App.Experiment.rootKey = 'experiment'
App.Experiment.collectionKey = 'experiments'
App.Experiment.camelizeKeys = true
App.Experiment.adapter = App.MetaRESTAdapter.create()
