egg.Events =
  
  emit: (event, arg={})->
    egg.publisher.emit(event, arg, @)

  on: (event, callback, filter)->
    egg.publisher.on event, callback, (e) =>
      if filter
        e.sender == @ && filter(e)
      else
        e.sender == @
