App.WebSocketDataAdapter = App.DataAdapter.extend
  ws: null
  frame: null

  _start: ()->
    connector = @get('connector')
    connector.send('connect', {connect: true, pps: 50, batch_size: 1})
      .then(() => @startStreaming())

    @set 'resolution', 50
    @set 'channels', 2

  startStreaming: ->
    console.log 'start streaming'
    url = @get('url')
    @ws = new WebSocket(url)

    @ws.onopen = () =>
      console.log('data socket open')

    @ws.onmessage = (evt) =>
      # data is an array of arrays, channel major
      data = JSON.parse(evt.data).data
      newFrame = []
      newFrame.push(data[i]) for i in [0...data.length]
      @frame = newFrame

    @ws.onclose = () =>
      console.log "data socket closed"

    @ws.onerror = () =>
      console.log "data socket error"

  _stop: ->
    console.log 'stopping streaming'
    connector = @get('connector')
    connector.send('connect', {connect: false})
      .then(() => @ws.close())

  sample: -> @frame