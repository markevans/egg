#= require_tree ./observers

class @ClockApp extends egg.View
  
  init: (opts)->
    clock = new Clock
    new AnalogueClockView elem: $('<div>').attr(id: 'analogue').appendTo($(@elem)), clock: clock
    new DigitalClockView elem: $('<div>').attr(id: 'digital').appendTo($(@elem)), clock: clock
