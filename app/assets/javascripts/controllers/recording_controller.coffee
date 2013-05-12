App.RecordingController = Em.ObjectController.extend
  edit: ->
    @set 'isEditing', true

  cancelEdit: ->
    @set 'isEditing', false

  saveEdit: ->
    @set 'isEditing', false