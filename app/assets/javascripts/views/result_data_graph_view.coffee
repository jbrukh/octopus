App.ResultDataGraphView = Em.View.extend
  canvasWidth:  920
  margins:      [5, 45, 50, 5]

  graphHeight: 100
  graphSpacing: 10
  overviewHeight: 30
  overviewSpacing: 40

  classNames: ['graph-view']

  tag: null

  didInsertElement: ->
    data = @get('resultData')
    throw 'result data not loaded' unless data.get('isLoaded')
    @drawGraphs(data)

  drawGraphs: (data) ->
    console.debug 'Drawing result data graph'

    @graphWidth = @canvasWidth - @margins[1] - @margins[3]

    samples     = data.get('samples')
    channels    = data.get('channels')
    buffers     = data.get('channelBuffers')
    timestamps  = data.get('timestamps')

    # create an svg element to contain all
    # the graphs, it should be big enough
    # to contain all the buffers, plus some
    # padding
    totalHeight =
      (@graphHeight * channels) +         # space for each graph
      (@graphSpacing * (channels - 1)) +  # space for padding between each graph
      @graphSpacing +                     # spacing for the axis
      @overviewHeight + @overviewSpacing +
      @margins[0] +
      @margins[2]

    element = this.$()[0].id
    svg = d3.select("##{element}")
      .append("svg:svg")
        .attr('class', 'graph-recording')
        .attr("width", @canvasWidth)
        .attr("height", totalHeight)

    x = d3.scale.linear()
      .range([0, @graphWidth])
      .domain([d3.min(timestamps), d3.max(timestamps)])

    xAxis = d3.svg.axis()
      .scale(x)
      .tickSize(-(totalHeight))
      .tickSubdivide(1)

    xAxisPosition = channels * @graphHeight + (channels * @graphSpacing) + @margins[0]
    svg.append("g")
      .attr("class", "x axis")
      .attr("transform", "translate(#{@margins[3]}," + xAxisPosition + ")")
      .call(xAxis)

    # draw each channel as a separate graph, stacked on top of each other
    [0...channels].map (i) =>
      @drawGraph(svg, i, buffers[i], timestamps, x)

    overviewPosition = xAxisPosition + @overviewSpacing
    @drawOverview(overviewPosition, svg, channels, buffers, x, timestamps)

  drawGraph: (svg, bufferIndex, buffer, timestamps, x) ->
    y = d3.scale.linear()
      .range([0, @graphHeight])
      .domain([d3.min(buffer), d3.max(buffer)])

    line = d3.svg.line()
      .interpolate('none')
      .x((d, i) => x(timestamps[i]))
      .y((d, i) => y(d))

    format = d3.format(",.4f")
    yAxis = d3.svg.axis()
      .scale(y)
      .ticks(2)
      .tickSize(3)
      .tickFormat((d, i) -> format(d))
      .orient("right")

    # create a new graphic element for this graph, and position
    # it correctly
    graphOffset = bufferIndex * @graphHeight + (bufferIndex * @graphSpacing) + @margins[0]
    graphic = svg.append("svg:g")
      .attr("transform", "translate(#{@margins[3]},#{graphOffset})")

    graphic.append("g")
      .attr("class", "y axis")
      .attr("transform", "translate(" + @graphWidth + ",0)")
      .call(yAxis)

    graphic.append("path")
      .data([buffer])
      .attr("class", "line channel-" + bufferIndex)
      .attr("d", line)

  drawOverview: (position, svg, channels, buffers, x, timestamps) ->
    # under the graph show all the channels combined into one
    overviewPosition = position
    overview = svg.append("svg:g")
      .attr("transform", "translate(#{@margins[3]}," + overviewPosition + ")")

    min = d3.min buffers.map((buffer) -> d3.min(buffer))
    max = d3.max buffers.map((buffer) -> d3.max(buffer))

    x2 = d3.scale.linear()
      .range([0, @graphWidth])
      .domain([d3.min(timestamps), d3.max(timestamps)])

    y2 = d3.scale.linear()
      .range([0, @overviewHeight])
      .domain([min, max])

    x2Position = position - 10

    xAxis = d3.svg.axis()
      .scale(x2)
      .tickSize(50)
      .tickSubdivide(1)

    svg.append("g")
      .attr("class", "x axis")
      .attr("transform", "translate(#{@margins[3]}," + x2Position + ")")
      .call(xAxis)

    brush = d3.svg.brush()
    brush.x(x2).on("brush", () => @onBrush(x, x2, brush))

    [0...channels].map (i) =>
      buffer = buffers[i]

      line = d3.svg.line()
        .interpolate('none')
        .x((d, i) => x2(timestamps[i]))
        .y((d, i) => y2(d))

      overview.append("path")
        .data([buffer])
        .attr("class", "line channel-" + i)
        .attr("d", line)

    overview.append("g")
      .attr("class", "x brush")
      .call(brush)
    .selectAll("rect")
      .attr("y", 0)
      .attr("height", 30);

  onBrush: (x, x2, brush)->
    x.domain = if brush.empty()
      @set 'tag.extent', null
      x2.domain()
    else
      @set 'tag.extent', brush.extent()
      brush.extent()

    # this is where we'll eventually resize the main graph for
    # focusing.
    #graph.select("path").attr("d", area);
    #graph.select(".x.axis").call(xAxis);