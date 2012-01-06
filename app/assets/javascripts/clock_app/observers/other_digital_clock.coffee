egg.observe OtherDigitalClock, egg.observers.DigitalClock,
  
  upSeconds: -> @clock.secondsUp()
  
  downSeconds: -> @clock.secondsDown()
