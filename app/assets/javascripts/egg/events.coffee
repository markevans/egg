eventsIDCounter = 0

egg.Events =

  onUse: (klass)->
    klass.include(@instanceMethods)
    klass.extend(@instanceMethods)

  instanceMethods:
  
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
      @_eventsID ?= (
        if @constructor.name == 'Function' && @name.length
          @name
        else
          "#{@constructor.name}-#{eventsIDCounter++}"
      )
