App.RecordingCloudController = Em.ObjectController.extend
  save: ->
    model = @get 'model'

    model.set 'name', @get('newName')
    model.set 'description', @get('newDescription')
    model.save().then =>
      @send('close')

  createTag: ->
    console.log 'create tag'
    tagging = @get 'tagging'
    tagging.save()