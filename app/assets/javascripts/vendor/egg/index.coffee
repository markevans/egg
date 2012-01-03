Object.extend = (obj, otherObjs...)->
  for otherObj in otherObjs
    obj[key] = value for key, value of otherObj
  obj

class Publisher

  constructor: ->
    @subscriptions = {}
  
  emit: (event, args={}, sender)->
    @runCallbacks(event, args, sender, event)
    @runCallbacks('*', args, sender, event)
    
  on: (event, callback, filter)->
    @subscriptions[event] ?= []
    @subscriptions[event].push callback: callback, filter: filter

  runCallbacks: (channel, args, sender, event)->
    if @subscriptions[channel]
      for s in @subscriptions[channel]
        s.callback.call(sender, args, event, sender) if !s.filter or s.filter(sender, args, event)

@egg =

  publisher: new Publisher

  observers: {}

  observe: (constructor, args...)->
    if args.length == 1
      opts = {}
      callbacks = args[0]
    else
      [opts, callbacks] = args
    if opts.include
      callbacks = Object.extend({}, @observers[opts.include.name], callbacks)
      console.log callbacks
    for name, callback of callbacks
      egg.publisher.on name, callback, (sender) -> sender.constructor == constructor
    @observers[constructor.name] = callbacks
  
  Events:
    
    emit: (event, args={})->
      egg.publisher.emit(event, args, @)

    on: (event, callback, filter)->
      egg.publisher.on event, callback, (sender, args) =>
        if filter
          sender == @ && filter(sender, args)
        else
          sender == @

class egg.Base

  @include: (obj)->
    Object.extend @::, obj

  @extend: (obj)->
    Object.extend @, obj

  @include egg.Events

  constructor: (args...)->
    @init(args...) if @init
    @emit('init', args: args)

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
