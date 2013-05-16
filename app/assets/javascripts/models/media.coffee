App.Media = DS.Model.extend
  name:       DS.attr 'string'
  createdAt:  DS.attr 'date'

App.Media.reopenClass
  types: ['video']