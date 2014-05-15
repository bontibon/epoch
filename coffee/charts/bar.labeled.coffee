class Epoch.Chart.LabeledBar extends Epoch.Chart.Bar
  constructor: (@options={}) ->
    @options.margins ?= {}
    @options.margins.top ?= 25
    super(@options)

  draw: ->
    super()

    [x0, y] = [@x(), @y()]
    x1 = @x1(x0)
    data = @_remapData()
    labelFunc = @options.label ? (d) -> d.y

    label = @svg.selectAll('.label')
      .data(data, (d) -> d.group)

    label.transition().duration(750)
      .attr("transform", (d) -> "translate(#{x0(d.group)}, 0)")

    label.enter().append("g")
      .attr('class', 'label')
      .attr("transform", (d) -> "translate(#{x0(d.group)}, 0)")

    text = label.selectAll('text')
      .data((group) -> group.values)

    text.transition().duration(600)
      .attr('x', (d) -> x1(d.label) + (x1.rangeBand() / 2))
      .attr('y', (d) -> y(d.y))
      .text(labelFunc)

    text.enter().append('text')
      .attr('text-anchor', 'middle')
      .attr('x', (d) -> x1(d.label) + (x1.rangeBand() / 2))
      .attr('y', (d) -> y(d.y))
      .attr('dy', '-.35em')
      .text(labelFunc)

    text.exit().transition()
      .duration(150)
      .style('opacity', '0')
      .remove()

    text2 = label.selectAll('text.group')
      .data((group) -> group.values)

    text2.transition().duration(600)
      .attr('x', (d) -> x1(d.label) + (x1.rangeBand() / 2))
      .attr('y', (d) -> y(d.y))
      .text((d) -> d.label[0])

    text2.enter().append('text')
      .attr('class', 'group')
      .attr('text-anchor', 'middle')
      .attr('x', (d) -> x1(d.label) + (x1.rangeBand() / 2))
      .attr('y', (d) -> y(d.y))
      .attr('dy', '1em')
      .text((d) ->  d.label[0])

    text2.exit().transition()
      .duration(150)
      .style('opacity', '0')
      .remove()

    label.exit()
      .transition()
      .duration(750)
      .style('opacity', '0')
      .remove()
