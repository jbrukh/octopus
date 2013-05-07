App.WebSocketDataAdapter = App.DataAdapter.extend
  ws: null
  frame: null
  didRun: false

  _start: ()->
    res = 50
    @set 'resolution', res
    @set 'didRun', true
    connector = @get('connector')
    connector.send('connect', {connect: true, pps: res, batch_size: 1})
      .then(() => @startStreaming())

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
      @frameReceived(newFrame)

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