egg.observe DigitalClock,
  
  up: -> @clock.minuteUp()
  
  down: -> @clock.minuteDown()
