describe 'App.PropertiesTransform', ->
  it 'converts properties into an object', ->
    properties = Em.A []

    properties.pushObject App.Property.create
      name: 'property1'
      value: 'value1'

    properties.pushObject App.Property.create
      name: 'property2'
      value: 'value2'

    serialized = App.PropertiesTransform.serialize(properties)
    expect(serialized['property1']).toEqual('value1')
    expect(serialized['property2']).toEqual('value2')

  it 'converts an object into properties', ->
    deserialized = App.PropertiesTransform.deserialize
      property1: 'value1'
      property2: 'value2'
    expect(deserialized.length).toEqual(2)
    expect(deserialized[0].get('name')).toEqual('property1')
    expect(deserialized[0].get('value')).toEqual('value1')