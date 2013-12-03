# App.VideoAdapter = Ember.RESTAdapter.extend
#   createRecord: (record) ->
#     name = record.get 'name'
#     data = record.get 'attachment.data'

#     csrf_token = $('meta[name=csrf-token]').attr('content')
#     csrf_param = $('meta[name=csrf-param]').attr('content')

#     formData = new FormData()
#     formData.append(csrf_param, csrf_token)
#     formData.append('video[name]', name)
#     formData.append('video[data]', data)

#     xhr = new XMLHttpRequest()
#     xhr.open('POST', '/api/videos', true)

#     deferred = Ember.Deferred.create()

#     xhr.onload = (e) ->
#       deferred.resolve(e)
#     xhr.send(formData)

#     deferred