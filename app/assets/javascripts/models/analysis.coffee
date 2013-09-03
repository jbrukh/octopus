attr = Ember.attr

App.Analysis = Ember.Model.extend
  id:         attr()
  algorithm:  attr()
  state:      attr()
  arguments:  attr(Properties)