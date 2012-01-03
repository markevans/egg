class @DigitalClock extends egg.View
  
  @on 'click', '.up', 'up'
  @on 'click', '.down', 'down'
  
  init: (opts)->
    @clock = opts.clock
    @render()
    @clock.on 'changed', @render
  
  render: =>
    $(@elem).html @template()(@clock)
  
  template: -> template['digital_clock']