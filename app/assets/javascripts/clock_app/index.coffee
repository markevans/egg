
class @ClockApp extends egg.View
  
  init: (opts)->
    clock = new Clock
    new AnalogueClock elem: @append('.analogue', @elem), clock: clock
    new AnalogueClock elem: @append('.analogue', @elem), clock: clock, radius: 50
    new DigitalClock elem: @append('.digital', @elem), clock: clock
    new OtherDigitalClock elem: @append('.other-digital', @elem), clock: clock
