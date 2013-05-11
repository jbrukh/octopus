App.Result = Ember.Object.extend
  cachedData: null

  data: (->
    return @cachedData if @cachedData != null

    console.log 'loading result data'
    @cachedData = App.ResultData.create()

    xhr = new XMLHttpRequest()
    xhr.open 'GET', @get('data_url'), true
    xhr.responseType = 'arraybuffer';

    xhr.onload = (e) =>
      dataView = new DataView(xhr.response)

      @cachedData.set 'dataType',       dataView.getUint8(0, false)
      @cachedData.set 'formatVersion',  dataView.getUint8(1, false)
      @cachedData.set 'rawStorageMode', dataView.getUint8(2, false)
      @cachedData.set 'channels',       dataView.getUint8(3, false)
      @cachedData.set 'samples',        dataView.getUint32(4, false)
      @cachedData.set 'sampleRate',     dataView.getUint16(8, false)

      @cachedData.set 'isLoaded', true
    xhr.send()
    @cachedData
  ).property()

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