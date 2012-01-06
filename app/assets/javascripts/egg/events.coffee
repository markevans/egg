egg.Events =
  
  emit: (event, args={})->
    egg.publisher.emit(event, args, @)

  on: (event, callback, filter)->
    egg.publisher.on event, callback, (e) =>
      if filter
        e.sender == @ && filter(e)
      else
        e.sender == @
