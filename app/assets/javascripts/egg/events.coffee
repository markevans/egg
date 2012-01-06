egg.Events =
  
  emit: (event, args={})->
    egg.publisher.emit(event, args, @)

  on: (event, callback, filter)->
    egg.publisher.on event, callback, (sender, args) =>
      if filter
        sender == @ && filter(sender, args)
      else
        sender == @
