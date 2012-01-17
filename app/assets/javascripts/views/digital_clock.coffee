class @DigitalClock extends egg.View
  
  @onDOM 'click', '.up', 'up'
  @onDOM 'click', '.down', 'down'

  @onObj 'changed', 'render'
  
  @className: 'digital'
  
  init: (opts)->
    @render()
  
  render: =>
    $(@elem).html @template()(@obj)
  
  template: -> template['digital_clock']