Properties =
  serialize: (value) ->
    result = {}
    return result unless value
    value.forEach (v) ->
      name = v.get('name')
      result[name] = v.get('value')
    result

  deserialize: (value) ->
    properties = Em.A []
    for name of value
      property = App.Property.create {
        name: name,
        value: value[name]
      }
      properties.pushObject(property)
    properties

root = exports ? this
root.Properties = Properties