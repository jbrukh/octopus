App.ResultDataGraphView = Em.View.extend
  graphWidth: 920
  graphHeight: 100
  graphPadding: 10

  classNames: ['graph-view']

  didInsertElement: ->
    data = @get('resultData')
    throw 'result data not loaded' unless data.get('isLoaded')
    @drawGraphs(data)

  drawGraphs: (data) ->
    console.debug 'Drawing result data graph'

    samples     = data.get('samples')
    channels    = data.get('channels')
    buffers     = data.get('channelBuffers')
    timestamps  = data.get('timestamps')

    # create an svg element to contain all
    # the graphs, it should be big enough
    # to contain all the buffers, plus some
    # padding
    totalHeight = (@graphHeight * channels) + (@graphPadding * channels) + @graphPadding

    element = this.$()[0].id
    svg = d3.select("##{element}")
      .append("svg:svg")
        .attr('class', 'graph-recording')
        .attr("width", @graphWidth)
        .attr("height", totalHeight)

    [0...channels].map (i) =>
      @drawGraph(svg, i, buffers[i], timestamps)

  drawGraph: (svg, bufferIndex, buffer, timestamps) ->

    x = d3.scale.linear()
      .range([50, @graphWidth])
      .domain([d3.min(timestamps), d3.max(timestamps)])

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
      .tickSize(2)
      .tickFormat((d, i) -> format(d))
      .orient("left")

    # create a new graphic element for this graph, and position
    # it correctly
    graphOffset = bufferIndex * @graphHeight + ((bufferIndex + 1) * @graphPadding)
    graphic = svg.append("svg:g")
      .attr("transform", "translate(0,#{graphOffset})")

    graphic.append("g")
      .attr("class", "y-axis")
      .attr("transform", "translate(" + 50 + ",0)")
      .call(yAxis)

    graphic.append("path")
      .data([buffer])
      .attr("class", "line channel-" + bufferIndex)
      .attr("d", line)