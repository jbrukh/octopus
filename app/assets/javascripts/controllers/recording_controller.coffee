App.RecordingController = Em.ObjectController.extend
  edit: ->
    @set 'isEditing', true

  cancelEdit: ->
    @set 'isEditing', false

  saveEdit: ->
    @set 'isEditing', false
    newDescription = @get 'newDescription'

    model = @get 'model'

    # this doesn't work... ember data sucks
    transaction = @get('store').transaction()
    model.set 'description', newDescription

    transaction.add(model)
    transaction.commit()