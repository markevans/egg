egg.observe OtherDigitalClock, egg.publisher.observers.DigitalClock,
  
  upSeconds: -> @clock.secondsUp()
  
  downSeconds: -> @clock.secondsDown()
