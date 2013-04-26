App.ExperimentsIndexView = Ember.View.extend({
  x: null,
  y: null,
  line: null,
  now: null,
  duration: null,
  width: null,
  height: null,
  bufferSize: null,
  buffers: null,
  pointsDrawn: null,

  didInsertElement: function(){
    var controller = this.get('controller');

    var _this = this;
    controller.on('didStart', function(){
      _this.initializeGraphPrimitives();
      _this.$('#graphs-container').html('');
      _this.createGraphs();
    });

    controller.on('didStop', function(){
      _this.destroyGraphs();
    });
  },

  initializeGraphPrimitives: function(){
    this.duration = 10;
    this.now = new Date(Date.now() - this.duration);
    this.width = 940;
    this.height = 60;
    this.bufferSize = 800;

    var duration = this.duration;
    var now = this.now;
    var width = this.width;
    var height = this.height;
    var bufferSize = this.bufferSize;

    this.x = d3.time.scale()
      .domain([now - (bufferSize - 2) * duration, now - duration])
      .range([0, width]);

    this.y = d3.scale.linear()
      .range([height, 0]);

    var x = this.x;
    var y = this.y;

    this.line = d3.svg.line()
      .interpolate("none")
      .x(function(d, i) { return x(now - (bufferSize - 1 - i) * duration); })
      .y(function(d, i) { return y(d); });
  },

  createGraphs: function(){
    console.log('creating graphs');

    var duration = this.duration;
    var now = this.now;
    var width = this.width;
    var height = this.height;
    var bufferSize = this.bufferSize;
    var x = this.x;
    var y = this.y;

    var controller = this.get('controller');
    var dataAdapter = controller.get('dataAdapter');

    this.buffers = this.createBuffers(dataAdapter);

    var line = d3.svg.line()
      .interpolate("none")
      .x(function(d, i) { return x(now - (bufferSize - 1 - i) * duration); })
      .y(function(d, i) { return y(d); });

    for(var i = 0 ; i < dataAdapter.get('channels'); ++i){
      this.createGraph(this.buffers, i);
    }

    this.buffers.start(50);
  },

  destroyGraphs: function(){
    console.log('destroy graphs');
    this.buffers.stop();
  },

  createBuffers: function(dataAdapter){
    var duration = this.duration;
    var now = this.now;
    var width = this.width;
    var height = this.height;
    var bufferSize = this.bufferSize;

    this.pointsDrawn = 0;
    p = this.pointsDrawn;

    var numChannels = dataAdapter.get('channels');

    console.log("creating " + numChannels  + " buffers of size " + bufferSize);

    var channels = [];
    var callbacks = [];

    var createRange = function(){
      return d3.range(bufferSize).map(function() { return 0; });
    };

    for(var i = 0 ; i < numChannels ; ++i){
      channels.push(createRange());
    }

    var _this = this;

    return {
      handle: null,
      get: function(){
        return channels;
      },
      start: function(frequency){
        console.log("starting buffers @ " + frequency);
        handle = setInterval(function(){
          var sample = dataAdapter.sample();
          for(var i = 0; i < numChannels; ++i){
            channels[i].push(sample[i]);
          }
          for(var c = 0 ; c < callbacks.length; ++c){
            var callback = callbacks[c];
            callback(channels, frequency);
          }
          for(var k = 0; k < numChannels; ++k){
            channels[k].shift();
          }
        }, frequency);
      },
      stop: function(){
        clearInterval(handle);
      },
      register: function(onData) {
        callbacks.push(onData);
      }
    };
  },

  createGraph: function(buffers, channel){
    var duration = this.duration;
    var now = this.now;
    var width = this.width;
    var height = this.height;
    var bufferSize = this.bufferSize;

    var selector = this.$();

    var svg = d3.select('#graphs-container')
      .append("svg")
      .attr("width", width)
      .attr("height", height)
      .append("g");

    var path = svg.append("path")
        .data([buffers.get()[channel]])
        .attr("class", "line channel-" + channel);

    var _this = this;

    buffers.register(function(channels, frequency){
      _this.now = new Date();
      _this.x.domain([now - (bufferSize - 2) * duration, now - duration]);
      _this.y.domain([d3.min(channels[channel]), d3.max(channels[channel])]);

      svg.select(".line")
          .attr("d", _this.line)
          .attr("transform", null);

      path.transition()
        .duration(frequency)
        .ease("linear")
        .attr("transform", "translate(" + _this.x(now - (bufferSize - 1) * duration) + ")");
    });
  }
});