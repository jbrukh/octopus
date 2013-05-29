# the properties transform is used to convert a hash
# to and from an array of properties
App.PropertiesTransform =
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

App.Store = DS.Store.extend
  adapter: DS.RESTAdapter

DS.RESTAdapter.configure "plurals",
  theory: "theories"
  video: "videos"

DS.RESTAdapter.reopen
  namespace: 'api'

DS.RESTAdapter.registerTransform 'properties', App.PropertiesTransform