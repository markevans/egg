class egg.View extends egg.Base

  @onDOM: (domEvent, selector, event, argsMap)->
    @delegatedEvents().push
      domEvent: domEvent
      selector: selector
      event: event
      argsMap: argsMap
    
  @delegatedEvents: ->
    @_delegatedEvents ?= []
  
  constructor: (opts={})->
    @elem = if opts.elem then $(opts.elem)[0] else throw("Missing elem!")
    @delegateEvents()
    @setClassName()
    super(opts)

  delegateEvents: ()->
    for d in @constructor.delegatedEvents()
      $(@elem).on d.domEvent, d.selector, d, (e) => @emit(e.data.event, (if e.data.argsMap then e.data.argsMap(e) else e))

  setClassName: ->
    if @constructor.className
      $(@elem).addClass(@constructor.className)
