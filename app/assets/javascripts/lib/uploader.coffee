App.Uploader = Em.Object.extend
  upload: (recording) ->
    switch App.Environment
      when 'development' then @uploadDirect(recording)
      else @uploadS3(recording)

  uploadDirect: (recording) ->
    console.log 'uploading recording (direct)'

    connector = @get('connector')
    authToken = @get('currentUser').get('authenticationToken')

    id          =  recording.get 'id'
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

    # siganture
    # policy
    # aws_access_key_id
    # aws_bucket
