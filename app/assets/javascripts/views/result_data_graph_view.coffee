App.ResultDataGraphView = Em.View.extend
  graphWidth: 920
  graphHeight: 50
  graphPadding: 10

  didInsertElement: ->
    data = @get('resultData')
    throw 'result data not loaded' unless data.get('isLoaded')
    @drawGraphs(data)

  drawGraphs: (data) ->
    console.debug 'Drawing result data graph'

    samples  = data.get('samples')
    channels = data.get('channels')
    buffers  = data.get('channelBuffers')

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
      @drawGraph(svg, i, buffers[i])

  drawGraph: (svg, bufferIndex, buffer) ->
    # create the d3 primitives we're going to be using
    # to draw the graphs
    x = d3.scale.linear()
      .range([0, @graphWidth])

    y = d3.scale.linear()
      .range([@graphHeight, 0])
      .domain [d3.min(buffer), d3.max(buffer)]

    line = d3.svg.line()
      .interpolate('none')
      .x((d, i) => x(i))
      .y((d, i) => y(d))

    # create a new graphic element for this graph, and position
    # it correctly
    graphOffset = bufferIndex * @graphHeight + ((bufferIndex + 1) * @graphPadding)
    graphic = svg.append("svg:g")
      .attr("transform", "translate(0,#{graphOffset})")

    graphic.append("path")
      .data([buffer])
      .attr("class", "line channel-" + bufferIndex)
      .attr("d", line)