App.User = DS.Model.extend
  email:                DS.attr 'string'
  role:                 DS.attr 'string'
  password:             DS.attr 'string'
  passwordConfirmation: DS.attr 'string'
  authenticationToken:  DS.attr 'string'