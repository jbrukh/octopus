App.Result = Ember.Object.extend

  data: (->
    console.info 'loading result data'
    resultData = App.ResultData.create()

    xhr = new XMLHttpRequest()
    xhr.open 'GET', @get('data_url'), true
    xhr.responseType = 'arraybuffer';

    xhr.onload = (e) =>
      dataView = new DataView(xhr.response)

      resultData.set 'dataType',       dataView.getUint8(0, false)
      resultData.set 'formatVersion',  dataView.getUint8(1, false)
      resultData.set 'rawStorageMode', dataView.getUint8(2, false)

      numChannels = dataView.getUint8(3, false)
      resultData.set 'channels',       numChannels

      numSamples = dataView.getUint32(4, false)
      resultData.set 'samples',        numSamples
      resultData.set 'sampleRate',     dataView.getUint16(8, false)

      throw 'unsupported format' unless resultData.get('storageMode') == 'parallel'

      # create a buffer for each channel
      channelBuffers = [0...numChannels].map () =>
        new Float64Array(numChannels * numSamples)

      headerSize = 10

      # sequential
      #for c in [0...numChannels]
      #  for s in [0...numSamples]
      #    offset = headerSize +
      #      (c * Float64Array.BYTES_PER_ELEMENT * numSamples) +
      #      (s * Float64Array.BYTES_PER_ELEMENT)
      #    channelBuffers[c][s] = dataView.getFloat64(offset, false)

      # parallel
      # for now keep a count of what to skip because we're not reading timestamps
      skip = 0
      for s in [0...numSamples]
        for c in [0...numChannels]
          offset = headerSize +
            (s * numChannels * Float64Array.BYTES_PER_ELEMENT) +
            (c * Float64Array.BYTES_PER_ELEMENT) +
            (skip * Float64Array.BYTES_PER_ELEMENT)
          channelBuffers[c][s] = dataView.getFloat64(offset, false)
        ++skip

      # can't read timestamps (yet), but they will eventually go in here
      # timeStamps = new Int32Array(numSamples)

      resultData.set 'isLoaded', true
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