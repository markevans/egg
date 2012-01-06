eventsIDCounter = 0

egg.Events =
  
  emit: (eventName, arg)->
    egg.publisher.emit(eventName, arg, @)

  on: (eventName, callback, filter)->
    @__eventsID ?= "#{@constructor.name}-#{eventsIDCounter++}"
    egg.publisher.on(eventName, callback, filter, @)
