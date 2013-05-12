App.Result = Ember.Object.extend

  data: (->
    dataUrl = @get 'data_url'
    console.info "Loading result data: #{dataUrl}"
    resultData = App.ResultData.create()

    xhr = new XMLHttpRequest()
    xhr.open 'GET', dataUrl, true
    xhr.responseType = 'arraybuffer'

    xhr.onload = (e) =>
      resultData.populateFromArrayBuffer xhr.response
    xhr.send()

    resultData
  ).property().cacheable()

App.Result.reopenClass
  find: (recording, id) ->
    recordingId = recording.get('id')
    result = App.Result.create { id: id }
    $.ajax({
      dataType: "json",
      url: "/api/recordings/#{recordingId}/results",
    }).success (data) ->
      result.setProperties data.result
      result.set 'isLoaded', true
    result