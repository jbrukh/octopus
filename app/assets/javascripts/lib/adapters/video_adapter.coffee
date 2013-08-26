App.VideoAdapter = Ember.Adapter.extend
  createRecord: (record) ->
    name = record.get 'name'
    data = record.get 'attachment.data'

    csrf_token = $('meta[name=csrf-token]').attr('content')
    csrf_param = $('meta[name=csrf-param]').attr('content')

    formData = new FormData()
    formData.append(csrf_token, csrf_param)
    formData.append('name', name)
    formData.append('data', data)

    xhr = new XMLHttpRequest()
    xhr.open('POST', '/api/videos', true)
    xhr.send(formData)
