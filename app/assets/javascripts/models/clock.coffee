class @Clock extends egg.Base
  
  init: ->
    @tick()
    @intervalID = window.setInterval =>
      @tick()
    , 1000
  
  hours: ->
    @time.getHours()
  
  minutes: ->
    @time.getMinutes()
  
  seconds: ->
    @time.getSeconds()

  toSeconds: ->
    @hours()*3600 + @minutes()*60 + @seconds()
  
  tick: ->
    @time = new Date()
    @emit 'tick'
