App.WebSocketDataAdapter = Em.Object.extend
  ws: null
  frame: null

  start: ->
    connector = @get('connector')
    connector.send('connect', {connect: true, pps: 50, batch_size: 1})
      .then(() => @startStreaming())

    @set 'resolution', 50
    @set 'channels', 2

  startStreaming: ->
    console.log 'start streaming'
    url = @get('url');
    @ws = new WebSocket(url);

    @ws.onopen = () =>
      console.log('data socket open');

    @ws.onmessage = (evt) =>
      data = JSON.parse(evt.data).data;
      newFrame = [];
      newFrame.push(data[i]) for i in [0...data.length]
      @frame = newFrame

    @ws.onclose = () =>
      console.log "data socket closed"

    @ws.onerror = () =>
      console.log "data socket error"

  stop: ->
    console.log 'stopping streaming'
    connector = @get('connector')
    connector.send('connect', {connect: false})
      .then(() => @ws.close())

  sample: ->
    if @frame != null
      return @frame
    else
      return null