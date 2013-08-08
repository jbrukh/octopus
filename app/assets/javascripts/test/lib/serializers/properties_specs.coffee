describe 'Properties', ->
  it 'serializes properties into an object', ->
    properties = Em.A []

    properties.pushObject App.Property.create
      name: 'property1'
      value: 'value1'

    properties.pushObject App.Property.create
      name: 'property2'
      value: 'value2'

    serialized = Properties.serialize(properties)
    expect(serialized['property1']).toEqual('value1')
    expect(serialized['property2']).toEqual('value2')

  it 'serializes empty object into a blank object', ->
    serialized = Properties.serialize(null)
    expect(Object.keys(serialized).length).toEqual(0)

  it 'deserializes an object into properties', ->
    deserialized = Properties.deserialize
      property1: 'value1'
      property2: 'value2'
    expect(deserialized.length).toEqual(2)
    expect(deserialized[0].get('name')).toEqual('property1')
    expect(deserialized[0].get('value')).toEqual('value1')