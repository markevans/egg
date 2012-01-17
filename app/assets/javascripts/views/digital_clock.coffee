class @DigitalClock extends egg.View
  
  @onObj 'changed', 'render'
  
  @onDOM 'click', '.up', 'up'
  @onDOM 'click', '.down', 'down'

  @className: 'digital'
  
  init: (opts)->
    @render()
  
  render: ->
    $(@elem).html @template()(@obj)
  
  template: -> template['digital_clock']