converter = new Showdown.converter()

Ember.Handlebars.registerBoundHelper 'markdown', (value, options) ->
  converted = converter.makeHtml(value)
  new Handlebars.SafeString(converted)