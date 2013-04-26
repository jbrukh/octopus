App.WebSocketDataAdapter = Em.Object.extend({
  ws: null,
  isStreaming: false,
  frame: null,

  start: function(){
    var url = this.get('url');
    this.ws = new WebSocket(url);

    this.set('resolution', 50);
    this.set('channels', 2);
    var _this = this;

    this.ws.onopen = function(){
      console.log('websocket open');
      var initialize = {
        connect: true,
        frequency: _this.get('resolution'),
        average: false
      };
      _this.ws.send(JSON.stringify(initialize));
    };

    this.ws.onmessage = function(evt){
      var data = JSON.parse(evt.data);

      if(_this.isStreaming){
        var rec = data.data;
        newFrame = [];
        for(var i = 0 ; i < _this.fastChannels; ++i){
          newFrame.push(rec[i]);
        }
        _this.frame = newFrame;
      } else{
        _this.fastChannels = data.channels;
        _this.set('channels', _this.fastChannels);
        _this.isStreaming = true;
        _this.frame = [];
      }
    };

    this.ws.onclose = function(){
      console.log("socket closed");
    };
  },

  stop: function(){
    var terminate = {
      connect: false
    };
    this.ws.send(JSON.stringify(terminate));
    this.isStreaming = false;
  },

  sample: function(){
    if(this.frame !== null){
      return this.frame;
    }else{
      return [0, 0];
    }
  }
});