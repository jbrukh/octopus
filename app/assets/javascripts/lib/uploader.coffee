App.Uploader = Em.Object.extend
  upload: (recording) ->
    switch App.Environment
      when 'development' then @uploadDirect(recording)
      else @uploadS3(recording)

  uploadDirect: (recording) ->
    console.log 'uploading recording (direct)'

    connector = @get('connector')
    authToken = @get('currentUser').get('authenticationToken')

    id          = recording.get 'id'
    resourceId  = recording.get 'resourceId'

    # calculate the current host name
    arr = window.location.href.split("/")
    rootPath = arr[0] + "//" + arr[2]

    payload = {
      resource_id: resourceId,
      destination: 'direct',

      upload_params: {
        token: authToken,
        endpoint: "#{rootPath}/api/results/#{id}"
      }
    }

    connector.send('upload', payload).then (data) =>
      recording.set 'state', 'uploaded'

  uploadS3: (recording) ->
    console.log 'uploading recording (s3)'

    connector = @get('connector')

    id          = recording.get 'id'
    resourceId  = recording.get 'resourceId'

    return new Ember.RSVP.Promise (resolve, reject) =>
      console.log 'Fetching policy'
      App.Policy.fetch(id).then (policy) =>
        payload = {
          resource_id: resourceId
          destination: 's3'
          upload_params:
            policy:             policy.get('contents')
            signature:          policy.get('signature')
            aws_access_key_id:  @get('s3AccessKeyId')
            aws_bucket:         @get('s3BucketName')
        }

        console.log "Sending s3 upload"
        connector.send('upload', payload).then (data) =>
          attachment = App.RecordingAttachment.create
            id: id
            dataContentType: 'application/octet-stream'
            dataFileName: data.response_fields.s3_key
            dataFileSize: data.response_fields.file_bytes
          attachment.set('isNew', false)
          attachment.set('isDirty', true)
          attachment.save().then =>
            recording.set 'state', 'uploaded'
            resolve()
