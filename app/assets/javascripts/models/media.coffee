App.Media = DS.Model.extend
  name: DS.attr 'string'

App.Media.reopenClass
  types: ['video']