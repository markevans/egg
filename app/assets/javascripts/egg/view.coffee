class egg.View extends egg.Base

  @on: (domEvent, selector, event, argsMap)->
    @delegatedEvents().push
      domEvent: domEvent
      selector: selector
      event: event
      argsMap: argsMap
    
  @delegatedEvents: ->
    @_delegatedEvents ?= []
  
  constructor: (args={})->
    @elem = if args.elem then $(args.elem)[0] else throw("Missing elem!")
    @delegateEvents()
    super(args)

  delegateEvents: ()->
    for d in @constructor.delegatedEvents()
      $(@elem).on d.domEvent, d.selector, d, (e) => @emit(e.data.event, (if e.data.argsMap then e.data.argsMap(e) else e))

  append: (selector, container)->
    [tagName, dot_or_hash, class_or_id] = selector.match(/^(\w+)?([\.#])?([\w_-]+)?$/)[1..3]
    tagName ?= "div"
    opts = if dot_or_hash == '.' then {class: class_or_id} else {id: class_or_id}
    $("<#{tagName}>", opts).appendTo($(container))