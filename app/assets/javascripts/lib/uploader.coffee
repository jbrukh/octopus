App.Uploader = Em.Object.extend
  upload: (recording) ->
    @uploadS3(recording)
    #switch App.Environment
    #  when 'development' then @uploadDirect(recording)
    #  else @uploadS3(recording)

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

    connector.send('upload', payload)

  uploadS3: (recording) ->
    console.log 'uploading recording (s3)'

    connector = @get('connector')

    id          = recording.get 'id'
    resourceId  = recording.get 'resourceId'

    # calculate the current host name
    arr = window.location.href.split("/")
    rootPath = arr[0] + "//" + arr[2]

    App.Policy.fetch(id).then (policy) =>
      payload =
        resource_id: resourceId
        destination: 's3'
        upload_params:
          policy:             policy.get('contents')
          signature:          policy.get('signature')
          aws_access_key_id:  @get('s3AccessKeyId')
          aws_bucket:         @get('s3BucketName')

      connector.send('upload', payload).then(data) =>
        console.log 'finished s3 upload'
        console.log data
        # update the server here with the file information