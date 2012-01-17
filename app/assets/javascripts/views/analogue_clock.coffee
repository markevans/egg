class @AnalogueClock extends egg.View

  @className: 'analogue'
  
  init: (opts)->
    @clock = opts.clock
    @radius = opts.radius || 100
    @render()
    @clock.on 'changed', @render
  
  render: =>
    $(@elem).html template['analogue_clock'](
      radius: @radius
      height: 2 * @radius
      hours:   @svgVector @cartesian(r: @radius*0.5, theta: (@clock.toSeconds()/12/3600)*2*Math.PI)
      minutes: @svgVector @cartesian(r: @radius*0.9, theta: (@clock.minutes()/60)*2*Math.PI)
      seconds: @svgVector @cartesian(r: @radius*0.9, theta: (@clock.seconds()/60)*2*Math.PI)
    )
  
  cartesian: (polar) ->
    x: polar.r * Math.cos(polar.theta)
    y: polar.r * Math.sin(polar.theta)
  
  svgVector: (v)->
    x: @radius + v.y
    y: @radius - v.x
