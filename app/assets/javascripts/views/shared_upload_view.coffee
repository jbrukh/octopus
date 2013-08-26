App.AttachmentView = Em.View.extend
  templateName: 'shared/attachment'
  classNames: ['file-target']
  classNameBindings: ['dropIndicator']
  value: null

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

    uploadFile = App.UploadFile.create
      fileName: file.name
      fileType: file.type
      fileSize: file.size
      lastModifiedDate: file.lastModifiedDate

    reader = new FileReader();
    reader.onload = (evt) =>
      console.log 'file successfully read'
      blob = new Blob([evt.target.result], {type: file.type})
      uploadFile.set 'data', blob
    reader.readAsArrayBuffer(file);

    # set the file on the upload controller
    @set 'isDragging', false
    @set 'value', uploadFile
    false