App.MockDataAdapter = Em.Object.extend({
  frame:  null,
  handle: null,

  start: function(){
    var resolution = this.get('resolution');
    var channels = this.get('channels');

    this.frame = [];
    for(var i = 0 ; i < channels ; ++i){
      this.frame.push(Math.floor((Math.random()*100)+1));
    }

    var _this = this;

    console.log("starting data adapter @ " + resolution);
    handle = setInterval(function(){
      var newFrame = [];
      for(var i = 0 ; i < channels ; ++i){
        var delta = 1 - Math.floor((Math.random()*3)) ;
        var val = Math.min(_this.frame[i] + delta, 100);
        val = Math.max(val, 0);
        newFrame.push(val);
      }
      _this.frame = newFrame;
    }, resolution);
  },

  stop: function(){
    clearInterval(handle);
    console.log('stopping mock data adapter');
  },

  sample: function(){
    return this.frame;
  }
});