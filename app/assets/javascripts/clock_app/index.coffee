#= require_tree ./observers

class @ClockApp extends egg.Base
  
  @use egg.View

  @init (opts)->
    clock = new Clock
    new AnalogueClock     elem: $('<div>').appendTo(@elem), obj: clock
    new AnalogueClock     elem: $('<div>').appendTo(@elem), obj: clock, radius: 50
    new DigitalClock      elem: $('<div>').appendTo(@elem), obj: clock
    new OtherDigitalClock elem: $('<div>').appendTo(@elem), obj: clock
