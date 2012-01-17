class @AnalogueClock extends egg.View

  @className: 'analogue'
  
  @onObj 'changed', 'render'
  
  init: (opts)->
    @radius = opts.radius || 100
    @render()
  
  render: ->
    $(@elem).html template['analogue_clock'](
      radius: @radius
      height: 2 * @radius
      hours:   @svgVector @cartesian(r: @radius*0.5, theta: (@obj.toSeconds()/12/3600)*2*Math.PI)
      minutes: @svgVector @cartesian(r: @radius*0.9, theta: (@obj.minutes()/60)*2*Math.PI)
      seconds: @svgVector @cartesian(r: @radius*0.9, theta: (@obj.seconds()/60)*2*Math.PI)
    )
  
  cartesian: (polar) ->
    x: polar.r * Math.cos(polar.theta)
    y: polar.r * Math.sin(polar.theta)
  
  svgVector: (v)->
    x: @radius + v.y
    y: @radius - v.x
