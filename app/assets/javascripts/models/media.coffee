attr = DS.attr

App.Media = DS.Model.extend
  name:         attr()
  description:  attr()
  createdAt:    attr('date')
  owner:        attr()

App.Media.reopenClass
  types: ['video']