App.Experiment = DS.Model.extend
  media: DS.belongsTo('App.Media')

  name:         DS.attr 'string'
  description:  DS.attr 'string'
  owner:        DS.attr 'string'
  created_at:   DS.attr 'date'
  updated_at:   DS.attr 'date'

  startTrial: ->
    App.Trial.create
      state: 'setup'
      experiment: this