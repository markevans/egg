eventsIDCounter = 0

instanceMethods =

  emit: (eventName, arg)->
    egg.publisher.emit(eventName, arg, @)

  on: (eventName, callback, filter)->
    egg.publisher.on(eventName, callback, filter, @)

  observe: (args...)->
    if args.length == 1
      for eventName, callback of args[0]
        egg.publisher.observe(eventName, callback, @)
    else
      [eventName, callback] = args
      egg.publisher.observe(eventName, callback, @)

  eventsID: ()->
    if @constructor.name == 'Function' && @name.length
      @name
    else
      @_eventsID ?= "#{@constructor.name}-#{eventsIDCounter++}"

egg.Events = (klass)->
  klass.include(instanceMethods)
  klass.extend(instanceMethods)
