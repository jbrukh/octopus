attr = Ember.attr

App.Media = Ember.Model.extend
  name:         attr()
  description:  attr()
  createdAt:    attr(Date)
  owner:        attr()

App.Media.reopenClass
  types: ['video']