App.ParticipantsNewController = Em.ObjectController.extend
  addProperty: ->
    name = @get 'propertyName'
    if @get('model').addProperty(name)
      @set 'propertyName', ''

  removeProperty: (property) ->
    @get('model').removeProperty(property)

  isValidProperty: (->
    name = @get('propertyName')
    return false unless name
    return false if name.length == 0
    !@get('model').hasProperty(name)
  ).property('propertyName')