App.FileUpload = Em.View.extend
  classNames: ['file-target']
  classNameBindings: ['dropIndicator']

  dropIndicator: (->
    return 'droppable-indicator' if(@get('isDragging'))
  ).property('isDragging')

  dragOver: (evt) ->
    @set 'isDragging', true
    evt.preventDefault()
    false

  dragLeave: (evt) ->
    @set 'isDragging', false
    evt.preventDefault()
    false

  drop: (evt) ->
    console.log 'drop'

    # get the files from here, and bind them to the model
    files = evt.originalEvent.dataTransfer.files

    evt.preventDefault()
    false