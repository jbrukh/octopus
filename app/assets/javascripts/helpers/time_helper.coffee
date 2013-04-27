Ember.Handlebars.registerBoundHelper 'secondsToTime', (value, options) ->
  pad = (s) ->
    s += "";
    s = "0" + s if s.length < 2
    s

  rounded = Math.round(value);
  seconds = rounded % 60;
  minutes = Math.floor(value / 60);
  "#{pad(minutes)}:#{pad(seconds)}"