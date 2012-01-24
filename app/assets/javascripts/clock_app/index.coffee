#= require_tree ./observers

class @ClockApp extends egg.Base
  
  @use egg.View

  @init (opts)->
    clock = Clock.create()
    AnalogueClock.create     elem: $('<div>').appendTo(@elem), obj: clock
    AnalogueClock.create     elem: $('<div>').appendTo(@elem), obj: clock, radius: 50
    DigitalClock.create      elem: $('<div>').appendTo(@elem), obj: clock
    OtherDigitalClock.create elem: $('<div>').appendTo(@elem), obj: clock
