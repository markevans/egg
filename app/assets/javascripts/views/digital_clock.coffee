class @DigitalClock extends egg.View
  
  @onObj 'changed', 'render'
  
  @onDOM '.up', 'click', 'up'
  @onDOM '.down', 'click', 'down'

  @className: 'digital'
  
  init: (opts)->
    @render()
  
  render: ->
    $(@elem).html @template()(@obj)
  
  template: -> template['digital_clock']