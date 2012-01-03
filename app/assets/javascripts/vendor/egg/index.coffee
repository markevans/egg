Object.extend = (obj, obj2)->
  obj[key] = value for key, value of obj2
  obj

class Publisher

  constructor: ->
    @callbacks = {}
  
  emit: (event, args={}, sender)->
    if @callbacks[event]
      for callback_and_filter in @callbacks[event]
        [callback, filter] = callback_and_filter
        callback.call(sender, args) if filter(sender, args)
    
  on: (event, callback, filter)->
    @callbacks[event] ?= []
    @callbacks[event].push [callback, filter]

@egg =

  publisher: new Publisher
  
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
  
  constructor: (args={})->
    @elem = if args.elem then $(args.elem)[0] else throw("Missing elem!")
    super(args)
