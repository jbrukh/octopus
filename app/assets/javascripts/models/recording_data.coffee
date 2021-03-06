App.RecordingData = Em.Object.extend
  storageMode: (->
    switch @get('rawStorageMode')
      when 1 then 'parallel'
      when 2 then 'sequential'
      when 3 then 'combined'
      else throw 'unknown storage mode'
  ).property('rawStorageMode')

  populateFromArrayBuffer: (arrayBuffer) ->
    dataView = new DataView arrayBuffer
    @populateFromDataView dataView

  populateFromDataView: (dataView) ->
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
    @set 'dataType', dataView.getUint8(0, false)
    formatVersion = dataView.getUint8(1, false)
    @set 'formatVersion', formatVersion

    @set 'rawStorageMode', dataView.getUint8(2, false)

    numChannels = dataView.getUint8(3, false)
    @set 'channels', numChannels

    numSamples = dataView.getUint32(4, false)
    @set 'samples', numSamples
    @set 'sampleRate', dataView.getUint16(8, false)

    headerSize = switch formatVersion
      when 1 then 10
      else 31

    return { headerSize, numSamples, numChannels }

  readBody: (dataView, headerSize, numChannels, numSamples) ->
    channelBuffers = [0...numChannels].map () =>
      new Float64Array(numSamples)

    timestamps = new Uint32Array(numSamples)

    params = [dataView, headerSize, numChannels, numSamples, channelBuffers, timestamps]

    switch @get('storageMode')
      when 'parallel' then @readParallel.apply(this, params)
      when 'sequential' then @readSequential.apply(this, params)
      when 'combined' then @readParallel.apply(this, params)
      else throw 'unsupported storage mode'

    @set 'channelBuffers', channelBuffers
    @set 'timestamps', timestamps

  readParallel: (dataView, headerSize, numChannels, numSamples, channelBuffers, timestamps) ->
    for s in [0...numSamples]
      # seek to the sample
      sampleStart = headerSize +
        (s * numChannels * Float64Array.BYTES_PER_ELEMENT) +
        (s * Uint32Array.BYTES_PER_ELEMENT)

      # read channel data
      for c in [0...numChannels]
        offset = sampleStart + (c * Float64Array.BYTES_PER_ELEMENT)
        channelBuffers[c][s] = dataView.getFloat64(offset, false)

      # read timestamp
      timestampOffset = sampleStart + (numChannels * Float64Array.BYTES_PER_ELEMENT)
      timestamps[s] = dataView.getUint32(timestampOffset, false)

  readSequential: (dataView, headerSize, numChannels, numSamples, channelBuffers, timestamps) ->
    #r read the samples, each channel is sequential
    for c in [0...numChannels]
      for s in [0...numSamples]
        offset = headerSize +
          (c * Float64Array.BYTES_PER_ELEMENT * numSamples) +
          (s * Float64Array.BYTES_PER_ELEMENT)
        channelBuffers[c][s] = dataView.getFloat64(offset, false)

    for s in [0...numSamples]
      timestampOffset = headerSize + (s * Uint32Array.BYTES_PER_ELEMENT)
      timestamps[s] = dataView.getUint32(timestampOffset, false)

  exportAsCsv: () ->
    timestamps = @get 'timestamps'
    channels = @get 'channels'
    channelBuffers = @get 'channelBuffers'
    samples = @get 'samples'

    csv = 'timestamps'
    for channel in [0...channels]
      csv += ',' + "channel#{channel}"
    csv += '\n'

    for sample in [0...samples]
      csv += timestamps[sample]
      for channel in [0...channels]
        csv += ',' + channelBuffers[channel][sample]
      csv += '\n'
    csv