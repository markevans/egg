#= require_tree ./observers

class @ClockApp extends egg.View
  
  init: (opts)->
    clock = new Clock
    new AnalogueClock elem: $('<div>').appendTo(@elem), clock: clock
    new AnalogueClock elem: $('<div>').appendTo(@elem), clock: clock, radius: 50
    new DigitalClock elem: $('<div>').appendTo(@elem), clock: clock
    new OtherDigitalClock elem: $('<div>').appendTo(@elem), clock: clock
