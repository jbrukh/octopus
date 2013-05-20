App.ParticipantsNewController = Em.ObjectController.extend
  addProperty: ->
    name = @get 'propertyName'
    if @get('model').addProperty(name)
      @set 'propertyName', ''

  removeProperty: (property) ->
    @get('model').removeProperty(property)

  propertyInvalid: (->
    name = @get('propertyName')
    return true unless name
    return true if name.length == 0
    @get('model').hasProperty(name)
  ).property('propertyName')