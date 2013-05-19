App.RecordingController = Em.ObjectController.extend
  edit: ->
    @set 'isEditing', true
    @set 'newName', @get('name')
    @set 'newDescription', @get('description')

  cancelEdit: ->
    @set 'isEditing', false

  saveEdit: ->
    @set 'isEditing', false

    model = @get 'model'

    transaction = model.get('transaction')
    model.set 'name', @get('newName')
    model.set 'description', @get('newDescription')
    transaction.commit()

  createTag: ->
    console.log 'create tag'
    tagging = @get 'tagging'
    tagging.save()