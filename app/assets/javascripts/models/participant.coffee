App.Participant = DS.Model.extend
  firstName:  DS.attr 'string'
  lastName:   DS.attr 'string'
  email:      DS.attr 'string'
  gender:     DS.attr 'string'
  birthday:   DS.attr 'string'

  fullName: (->
    first = @get('firstName')
    last = @get('lastName')
    "#{last}, #{first}"
  ).property('firstName', 'lastName')

  age: (->
    birthday = @get('birthday')
    return null if birthday == null
    diff = moment() - moment(birthday)
    return Math.floor(diff / (1000 * 60 * 60 * 24 * 365.25))
  ).property('birthday')

App.Participant.reopenClass
  genders: [
    Em.Object.create({id: 'm', gender: 'Male'}),
    Em.Object.create({id: 'f', gender: 'Female'})
  ]