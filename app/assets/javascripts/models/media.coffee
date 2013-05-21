App.Media = DS.Model.extend
  name:         DS.attr 'string'
  description:  DS.attr 'string'
  createdAt:    DS.attr 'date'
  owner:        DS.attr 'string'

App.Media.reopenClass
  types: ['video']