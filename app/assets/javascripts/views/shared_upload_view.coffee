App.SharedUploadView = Em.View.extend
  classNames: ['file-target']
  classNameBindings: ['dropIndicator']

  dropIndicator: (->
    return 'droppable-indicator' if @get('isDragging')
  ).property('isDragging')

  dragOver: (evt) ->
    evt.preventDefault()
    @set 'isDragging', true
    false

  dragLeave: (evt) ->
    evt.preventDefault()
    @set 'isDragging', false
    false

  drop: (evt) ->
    evt.preventDefault()

    # get the files from here, and bind them to the model
    files = evt.originalEvent.dataTransfer.files

    # if you select multiple files we're only going
    # to take the first one
    file = files[0]

    # set the file on the upload controller
    @set 'controller.file', App.UploadFile.create
      fileName: file.name
      fileType: file.type
      fileSize: file.size
      lastModifiedDate: file.lastModifiedDate

    @set 'isDragging', false
    false