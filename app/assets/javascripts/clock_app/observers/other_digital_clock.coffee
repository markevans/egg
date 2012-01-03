egg.observe OtherDigitalClock, include: DigitalClock,
  
  upSeconds: -> @clock.secondsUp()
  
  downSeconds: -> @clock.secondsDown()
