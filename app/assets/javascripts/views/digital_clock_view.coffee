class @DigitalClockView extends egg.View
  
  init: (opts)->
    @clock = opts.clock
    @render()
    @clock.on 'tick', @render
  
  render: =>
    $(@elem).html template['digital_clock'](@clock)