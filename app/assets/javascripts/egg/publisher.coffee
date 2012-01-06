class egg.Publisher

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


egg.publisher = new egg.Publisher
