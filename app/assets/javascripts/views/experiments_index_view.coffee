App.ExperimentsIndexView = Ember.View.extend

  graphDurationInSeconds: 30
  graphWidth: 940
  graphHeight: 60
  graphPadding: 10

  dataPoints: null
  handle: null

  didInsertElement: ->
    @setupGraphs()
    controller = @get 'controller'
    controller.on 'didStart', => @startGraphing()
    controller.on 'didStop', => @stopGraphing()

  willDestroyElement: ->
    console.debug 'unregistering event listeners'
    controller = @get 'controller'
    controller.off 'didStart'
    controller.off 'didStop'

  setupGraphs: ->
    console.log "creating graph (#{@graphWidth}x#{@graphHeight})"
    console.log " - duration #{@graphDurationInSeconds} seconds"

    # create the d3 primitives we're going to be using
    # to draw the graphs
    @x = d3.scale.linear()
      .range([0, @graphWidth])
      .domain([@graphWidth, 0])

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
    console.log 'start graphing'
    @clearCurrentGraph()
    @dataAdapter = @get('controller.dataAdapter');

    @numChannels = @dataAdapter.get('channels')
    console.log "creating #{@numChannels} graph buffers"

    # create the buffers we're going to be charting
    @buffers = [0...@numChannels].map () =>
      d3.range(@graphWidth).map(-> 0)

    # create an svg element to contain all
    # the graphs, it should be big enough
    # to contain all the buffers, plus some
    # padding

    totalHeight = (@graphHeight * @numChannels) + (@graphPadding * @numChannels)

    svg = d3.select('#graphs-container')
      .append("svg:svg")
        .attr('class', 'graph-streaming')
        .attr("width", @graphWidth)
        .attr("height", totalHeight)

    @graphs = [0...@numChannels].map (i) =>
      @createGraph(svg, i)

    @startUpdateLoop()

  clearCurrentGraph: ->
    console.debug 'clearing current graph'
    this.$('#graphs-container').html ''

  createGraph: (svg, bufferIndex) ->
    graphOffset = bufferIndex * @graphHeight + ((bufferIndex + 1) * @graphPadding)
    g = svg.append("svg:g")
      .attr("transform", "translate(0," + graphOffset + ")")

    buffer = @buffers[bufferIndex]
    path = g.append("path")
      .data([buffer])
      .attr("class", "line channel-" + bufferIndex);

    return { svg: g, path: path }

  startUpdateLoop: ->
    updateFrequency = Math.round((@graphDurationInSeconds * 1000) / @graphWidth)
    console.log "starting update loop with frequency of #{updateFrequency}"
    @handle = setInterval((() => @onUpdateInterval(updateFrequency)), updateFrequency)

  onUpdateInterval: (updateFrequency) ->
    sample = @dataAdapter.sample()
    for i in [0...@numChannels]
      buffer = @buffers[i]
      buffer.push sample[i]
      buffer.shift()
      svg = @graphs[i].svg
      path = @graphs[i].path

      @y.domain [d3.min(buffer), d3.max(buffer)]
      svg.select(".line").attr("d", @line)

  stopGraphing: ->
    clearInterval(@handle)