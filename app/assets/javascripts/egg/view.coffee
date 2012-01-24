egg.View = (klass)->

  klass.extend
    onDOM: (selector, domEvent, event, argsMap)->
      @delegatedEvents()["#{domEvent}-#{selector}"] =
        domEvent: domEvent
        selector: selector
        event: event
        argsMap: argsMap
  
    delegatedEvents: ->
      @_delegatedEvents ?= {}

    onObj: (eventName, method)->
      @objectSubscriptions()[eventName] =
        eventName: eventName
        method: method
  
    objectSubscriptions: ->
      @_objectSubscriptions ?= {}

  klass.init (opts)->
    @elem = if opts.elem then $(opts.elem)[0] else throw("Missing elem!")
    @obj = opts.obj
    @delegateEvents()
    @subscribeToObj() if @obj
    @setClassName()
      
  klass.include
    delegateEvents: ->
      for key, d of @constructor.delegatedEvents()
        $(@elem).on d.domEvent, d.selector, d, (e) =>
          @emit(e.data.event, (if e.data.argsMap then e.data.argsMap(e) else e))
          e.stopPropagation()
          e.preventDefault()

    subscribeToObj: ->
      for key, s of @constructor.objectSubscriptions()
        @obj.on s.eventName, (args...) => @[s.method](args...)

    setClassName: ->
      if @constructor.className
        $(@elem).addClass(@constructor.className)
