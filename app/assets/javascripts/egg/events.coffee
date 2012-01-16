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

    eventsID: ()->
      @_eventsID ?= (
        if @constructor.name == 'Function' && @name.length
          @name
        else
          "#{@constructor.name}-#{eventsIDCounter++}"
      )
