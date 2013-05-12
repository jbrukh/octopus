App.ResultData = Em.Object.extend
  storageMode: (->
    switch @get('rawStorageMode')
      when 1 then 'parallel'
      when 2 then 'sequential'
      else throw 'unknown storage mode'
  ).property('rawStorageMode')

  populateFromArrayBuffer: (arrayBuffer) ->
    dataView = new DataView arrayBuffer

    start = new Date().getTime()

    header = @readHeader(dataView)
    @readBody(
      dataView,
      header.headerSize,
      header.numChannels,
      header.numSamples)
    elapsed = new Date().getTime() - start

    console.log "Parsed and loaded #{header.numSamples} samples in #{elapsed}ms"

    @set 'isLoaded', true

  readHeader: (dataView) ->
    @set 'dataType',       dataView.getUint8(0, false)
    @set 'formatVersion',  dataView.getUint8(1, false)
    @set 'rawStorageMode', dataView.getUint8(2, false)

    numChannels = dataView.getUint8(3, false)
    @set 'channels',       numChannels

    numSamples = dataView.getUint32(4, false)
    @set 'samples',        numSamples
    @set 'sampleRate',     dataView.getUint16(8, false)

    return {
      headerSize: 10,
      numSamples: numSamples,
      numChannels: numChannels
    }

  readBody: (dataView, headerSize, numChannels, numSamples) ->
    channelBuffers = [0...numChannels].map () =>
      new Float64Array(numSamples)

    switch @get('storageMode')
      when 'parallel' then @readParallel(dataView, headerSize, numChannels, numSamples, channelBuffers)
      when 'sequential' then @readSequential(dataView, headerSize, numChannels, numSamples, channelBuffers)
      else throw 'unsupported storage mode'

    @set 'channelBuffers', channelBuffers

  readParallel: (dataView, headerSize, numChannels, numSamples, channelBuffers) ->
    skip = 0
    for s in [0...numSamples]
      for c in [0...numChannels]
        offset = headerSize +
          (s * numChannels * Float64Array.BYTES_PER_ELEMENT) +
          (c * Float64Array.BYTES_PER_ELEMENT) +
          (skip * Float64Array.BYTES_PER_ELEMENT)
        channelBuffers[c][s] = dataView.getFloat64(offset, false)
      ++skip

  readSequential: (dataView, headerSize, numChannels, numSamples, channelBuffers) ->
    for c in [0...numChannels]
      for s in [0...numSamples]
        offset = headerSize +
          (c * Float64Array.BYTES_PER_ELEMENT * numSamples) +
          (s * Float64Array.BYTES_PER_ELEMENT)
        channelBuffers[c][s] = dataView.getFloat64(offset, false)