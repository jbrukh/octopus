App.Participant = DS.Model.extend
  firstName:  DS.attr 'string'
  lastName:   DS.attr 'string'
  email:      DS.attr 'string'
  gender:     DS.attr 'string'
  birthday:   DS.attr 'string'

App.Participant.reopenClass
  genders: [
    Em.Object.create({id: 'm', gender: 'Male'}),
    Em.Object.create({id: 'f', gender: 'Female'})
  ]