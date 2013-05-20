App.ParticipantsNewController = Em.ObjectController.extend
  addProperty: ->
    name = @get 'newFieldName'
    if @get('model').addProperty(name)
      @set 'newFieldName', ''

  removeProperty: (property) ->
    @get('model').removeProperty(property)