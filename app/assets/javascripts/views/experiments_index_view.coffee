App.ExperimentsIndexView = Ember.View.extend

  graphDurationInSeconds: 60
  graphWidth: 940
  graphHeight: 60

  dataPoints: null
  handle: null

  didInsertElement: ->
    controller = @get 'controller'

    @setupGraphs()

    # register controller events
    controller.on 'didStart', =>
      console.log 'did start'
      @startGraphing()

    controller.on 'didStop', =>
      console.log 'did stop'
      @stopGraphing()

  setupGraphs: ->
    console.log "creating graph (#{@graphWidth}x#{@graphHeight})"
    console.log " - duration #{@graphDurationInSeconds} seconds"

    # create the d3 primitives we're going to be using
    # to draw the graphs
    @x = d3.scale.linear()
      .range([0, @graphWidth])
      .domain([0, @graphWidth])

    @y = d3.scale.linear()
      .range([@graphHeight, 0])

    # x scale will have the resolution of the width of the graph
    # because there is no scaling the location is just the width
    # of the graph less the index into the buffer

    @line = d3.svg.line()
      .interpolate('none')
      .x((d, i) => @x(@graphWidth - i))
      .y((d, i) => @y(d));

  startGraphing: ->
    @clearCurrentGraph()
    @dataAdapter = @get('controller.dataAdapter');

    numChannels = @dataAdapter.get('channels')
    console.log "creating #{numChannels} graph buffers"

    # create the buffers we're going to be charting
    @buffers = [0..numChannels].map () =>
      d3.range(@graphWidth).map(-> 0)

    console.log(@buffers[0].length)

    @graphs = [0..numChannels].map (i) =>
      @createGraph(i)

    @dataAdapter.start()
    @startUpdateLoop()

  clearCurrentGraph: ->
    @.$('#graphs-container').html ''

  createGraph: (bufferIndex) ->
    margins = [1, 1, 1, 1];

    svg = d3.select('#graphs-container')
      .append("svg:svg")
        .attr('class', 'graph-streaming')
        .attr("width", @graphWidth + margins[1] + margins[3])
        .attr("height", @graphHeight + margins[0] + margins[2])
      .append("svg:g")
        .attr("transform", "translate(" + margins[3] + "," + margins[0] + ")")

    buffer = @buffers[bufferIndex]
    path = svg.append("path")
      .data([buffer])
      .attr("class", "line channel-" + bufferIndex);
    return {svg: svg, path: path}

  startUpdateLoop: ->
    updateFrequency = (@graphDurationInSeconds * 1000) / @graphWidth
    console.log "starting update loop with frequency of #{updateFrequency}"
    @handle = setInterval((() => @onUpdateInterval(updateFrequency)), updateFrequency)

  onUpdateInterval: (updateFrequency) ->
    sample = @dataAdapter.sample()
    for i in [0..@dataAdapter.get('channels')]
      buffer = @buffers[i]
      buffer.push(sample[i])
      svg = @graphs[i].svg
      path = @graphs[i].path

      @y.domain([d3.min(buffer), d3.max(buffer)]);

      svg.select(".line")
        .attr("d", @line)
        .attr("transform", null)

      path.transition()
        .duration(updateFrequency)
        .ease("linear")
        .attr("transform", "translate(" + 1 + ")");
      buffer.shift()

  stopGraphing: ->
    clearInterval(@handle)