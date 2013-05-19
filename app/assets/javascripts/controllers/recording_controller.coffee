App.RecordingController = Em.ObjectController.extend
  edit: ->
    @set 'isEditing', true
    @set 'newDescription', @get('description')

  cancelEdit: ->
    @set 'isEditing', false

  saveEdit: ->
    @set 'isEditing', false

    newDescription = @get 'newDescription'
    model = @get 'model'

    transaction = model.get('transaction')
    model.set 'description', newDescription
    transaction.commit()

  createTag: ->
    console.log 'create tag'
    tagging = @get 'tagging'
    tagging.save()