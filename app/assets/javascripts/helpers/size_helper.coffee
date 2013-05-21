Ember.Handlebars.registerBoundHelper 'megabytes', (value, options) ->
  k = (value / 1000000).toFixed(2)
  return k + " mb"