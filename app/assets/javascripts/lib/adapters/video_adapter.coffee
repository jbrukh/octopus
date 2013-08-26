App.VideoAdapter = Ember.Adapter.extend
  createRecord: (record) ->
    name = record.get 'name'
    data = record.get 'attachment.data'

    debugger

    csrf_token = $('meta[name=csrf-token]').attr('content')
    csrf_param = $('meta[name=csrf-param]').attr('content')

    formData = new FormData()
    #formData.append('video[name]', name)
    formData.append('video[data]', data)

    xhr = new XMLHttpRequest()
    xhr.open('POST', '/api/videos', true)
    xhr.send(formData)
    #$.ajax
    #  url: 'api/videos',
    #  data: formData,
    #  cache: false,
    #  contentType: false,
    #  processData: false,
    #  type: 'POST',
    #  success: (response) ->
    #      console.log(response)
