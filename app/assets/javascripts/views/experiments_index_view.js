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
    this.now = Date.now();
    this.width = 940;
    this.height = 60;
    this.bufferSize = 940;

    var duration = this.duration;
    var now = this.now;
    var width = this.width;
    var height = this.height;
    var bufferSize = this.bufferSize;

    this.x = d3.time.scale()
      .range([0, width]);

    this.x = d3.scale.linear()
      .range([0, width]);

    this.y = d3.scale.linear()
      .range([height, 0]);

    var x = this.x;
    var y = this.y;

    // create a line definition, this is used to convert a dataset
    // into a set of points, that can be drawn as a line

    this.line = d3.svg.line()
      .interpolate("none")
      .x(function(d, i) { return x(now - (bufferSize - i) * duration); })
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

    for(var i = 0 ; i < dataAdapter.get('channels'); ++i){
      this.createGraph(this.buffers, i);
    }

    this.buffers.start(this.duration);
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

    var margins = [1, 1, 1, 1];

    $('#graphs-container').hide();

    var svg = d3.select('#graphs-container')
      .append("svg:svg")
        .attr('class', 'graph-streaming')
        .attr("width", width + margins[1] + margins[3])
        .attr("height", height + margins[0] + margins[2])
      .append("svg:g")
        .attr("transform", "translate(" + margins[3] + "," + margins[0] + ")");

    var path = svg.append("path")
        .data([buffers.get()[channel]])
        .attr("class", "line channel-" + channel);

    var _this = this;

    buffers.register(function(channels, frequency){
      // reset the domain based on the current time and
      // set of points

      _this.now = new Date();
      _this.x.domain([now - (bufferSize * duration), now]);
      _this.y.domain([d3.min(channels[channel]), d3.max(channels[channel])]);

      svg.select(".line")
          .attr("d", _this.line)
          .attr("transform", null);

      path.transition()
        .duration(frequency)
        .ease("linear")
        .attr("transform", "translate(" + _this.x(now - (bufferSize * duration)) + ")");
    });

    $('#graphs-container').fadeIn();
  }
});