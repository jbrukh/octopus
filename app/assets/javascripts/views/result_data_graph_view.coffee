App.ResultDataGraphView = Em.View.extend
  canvasWidth:  920
  margins:      [5, 45, 50, 5]

  graphHeight: 100
  graphSpacing: 10

  classNames: ['graph-view']

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

    svg.append("g")
      .attr("class", "x axis")
      .attr("transform", "translate(#{@margins[3]}," + (totalHeight - @margins[2] + @graphSpacing) + ")")
      .call(xAxis)

    [0...channels].map (i) =>
      @drawGraph(svg, i, buffers[i], timestamps, x)

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