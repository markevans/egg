class @DigitalClock extends egg.View
  
  @onDOM 'click', '.up', 'up'
  @onDOM 'click', '.down', 'down'
  
  init: (opts)->
    @clock = opts.clock
    @render()
    @clock.on 'changed', @render
  
  render: =>
    $(@elem).html @template()(@clock)
  
  template: -> template['digital_clock']