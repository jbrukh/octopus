App.WebSocketDataAdapter = Em.Object.extend
  ws: null
  isStreaming: false
  frame: null

  start: ->
    url = @get('url');
    @ws = new WebSocket(url);

    @set('resolution', 50);
    @set('channels', 2);

    @ws.onopen = () =>
      console.log('websocket open');
      initialize = {
        connect: true,
        frequency: _this.get('resolution'),
        average: false
      }
      @ws.send(JSON.stringify(initialize));

    @ws.onmessage = (evt) =>
      data = JSON.parse(evt.data);

      if @isStreaming
        rec = data.data;
        newFrame = [];
        newFrame.push(rec[i]) for i in [0..@fastChannels]
        @frame = newFrame;
      else
        @fastChannels = data.channels;
        @set('channels', @fastChannels);
        @isStreaming = true;
        @frame = [];

    @ws.onclose = () ->
      console.log("socket closed");

  stop: ->
    terminate = {
      connect: false
    };
    @ws.send(JSON.stringify(terminate));
    @isStreaming = false;

  sample: ->
    if @frame != null
      return @frame
    else
      return [0, 0]