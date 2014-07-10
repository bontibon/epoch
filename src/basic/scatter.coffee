# Static scatter plot implementation (using d3).
class Epoch.Chart.Scatter extends Epoch.Chart.Plot
  defaults =
    r: 'r'
    radius: 3.5
    axes: ['top', 'bottom', 'left', 'right']

  # Creates a new scatter plot.
  # @param [Object] options Options for the plot.
  # @option options [Number] radius The default radius to use for the points in the plot (default 3.5). This can be overrwitten by individual points.
  constructor: (@options={}) ->
    super(@options = Epoch.Util.defaults(@options, defaults))

  # TODO: document me
  _getR: (d) ->
    r = @options.r
    if Epoch.isFunction(r) then r(d) else d[r]

  # Draws the scatter plot.
  draw: ->
    [x, y] = [@x(), @y()]
    radius = @options.radius

    layer = @svg.selectAll('.layer')
      .data(@data, (d) -> d.category)

    layer.enter().append('g')
      .attr('class', (d) -> d.className)

    dots = layer.selectAll('.dot')
      .data((l) -> l.values)

    dots.transition().duration(500)
      .attr("r", (d) => @_getR(d) ? radius)
      .attr("cx", (d) => x(@_getX(d)))
      .attr("cy", (d) => y(@_getY(d)))

    dots.enter().append('circle')
      .attr('class', 'dot')
      .attr("r", (d) => @_getR(d) ? radius)
      .attr("cx", (d) => x(@_getX(d)))
      .attr("cy", (d) => y(@_getY(d)))

    dots.exit().transition()
      .duration(750)
      .style('opacity', 0)
      .remove()

    layer.exit().transition()
      .duration(750)
      .style('opacity', 0)
      .remove()
      
    super()
