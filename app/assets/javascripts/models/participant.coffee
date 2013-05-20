App.Participant = DS.Model.extend
  firstName:  DS.attr 'string'
  lastName:   DS.attr 'string'
  email:      DS.attr 'string'
  gender:     DS.attr 'string'
  birthday:   DS.attr 'string'

  properties: DS.attr 'properties'

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

  addProperty: (name) ->
    properties = @get('properties')

    # there's no default value for properties, so we have to
    # initialize it to an empty array if it's empty
    unless properties
      @set 'properties', Em.A([])
      properties = @get('properties')

    # don't add duplicate properties
    return if properties.findProperty('name', name)

    property = App.Property.create({name: name})
    properties.pushObject(property)
    property

App.Participant.reopenClass
  genders: [
    Em.Object.create({id: 'm', gender: 'Male'}),
    Em.Object.create({id: 'f', gender: 'Female'})
  ]