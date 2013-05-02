App.ExperimentsIndexView = Ember.View.extend

  graphDurationInSeconds: 30
  graphWidth: 940
  graphHeight: 60
  graphPadding: 10
  currentBufferSize: null

  dataPoints: null
  handle: null

  didInsertElement: ->
    controller = @get 'controller'
    controller.on 'didStart', => @startGraphing()
    controller.on 'didStop', => @stopGraphing()

  willDestroyElement: ->
    console.debug 'unregistering event listeners'
    controller = @get 'controller'
    controller.off 'didStart'
    controller.off 'didStop'

  startGraphing: ->
    console.log 'start graphing'
    @clearCurrentGraph()
    @dataAdapter = @get('controller.dataAdapter')

    @currentBufferSize = @graphWidth
    @numChannels = @dataAdapter.get('channels')
    console.log "creating #{@numChannels} graph buffers"

    # create the buffers we're going to be charting
    @buffers = [0...@numChannels].map () => d3.range(0)

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
    # create the d3 primitives we're going to be using
    # to draw the graphs
    x = d3.scale.linear()
      .range([0, @graphWidth])
      .domain([@graphWidth, 0])

    y = d3.scale.linear()
      .range([@graphHeight, 0])

    line = d3.svg.line()
      .interpolate('none')
      .x((d, i) => x(@graphWidth - i - @currentBufferSize))
      .y((d, i) => y(d))

    format = d3.format(",.4f")
    yAxis = d3.svg.axis()
      .scale(y)
      .ticks(1)
      .tickSize(0)
      .tickFormat((d, i) -> format(d))
      .orient("left");

    # create a new graphic element for this graph, and position
    # it correctly
    graphOffset = bufferIndex * @graphHeight + ((bufferIndex + 1) * @graphPadding)
    graphic = svg.append("svg:g")
      .attr("transform", "translate(0,#{graphOffset})")

    graphic.append("g")
      .attr("class", "y-axis")
      .attr("transform", "translate(" + 50 + ",0)")
      .call(yAxis);

    # grab the buffer for this graph and
    # create a new line for it
    buffer = @buffers[bufferIndex]

    graphic.append("path")
      .data([buffer])
      .attr("class", "line channel-" + bufferIndex)

    return { graphic: graphic, y: y, line: line, yAxis: yAxis }

  startUpdateLoop: ->
    updateFrequency = Math.round((@graphDurationInSeconds * 1000) / @graphWidth)
    console.log "starting update loop with frequency of #{updateFrequency}"
    @handle = setInterval((() => @onUpdateInterval(updateFrequency)), updateFrequency)

  onUpdateInterval: (updateFrequency) ->
    sample = @dataAdapter.sample()
    return unless sample

    # update the current buffer size, this is used to
    # offset the channels so they start from the right
    --@currentBufferSize if @currentBufferSize > 0

    for i in [0...@numChannels]
      buffer = @buffers[i]
      buffer.push sample[i]
      buffer.shift() if buffer.length > @graphWidth

      graph = @graphs[i]
      graph.y.domain [d3.min(buffer), d3.max(buffer)]
      graph.graphic.select(".line").attr("d", graph.line)
      graph.graphic.select('.y-axis').call(graph.yAxis)

  stopGraphing: ->
    clearInterval(@handle)