App.Participant = DS.Model.extend
  firstName:  DS.attr 'string'
  lastName:   DS.attr 'string'
  email:      DS.attr 'string'
  gender:     DS.attr 'string'
  birthday:   DS.attr 'datetime'
