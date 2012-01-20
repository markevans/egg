class @Clock extends egg.Base
  
  @init (opts={})->
    @msOffset = if opts.offset then opts.offset*1000 else 0
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
    @time = new Date((new Date).getTime() + @msOffset)
    @emit 'changed'

  changeOffset: (amount)->
    @msOffset += amount
    @tick()

  minuteUp: -> @changeOffset(60000)

  minuteDown: -> @changeOffset(-60000)

  secondsUp: -> @changeOffset(1000)

  secondsDown: -> @changeOffset(-1000)
