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
    trial = App.Trial.create
      state: 'setup'
      experiment: this

    return trial