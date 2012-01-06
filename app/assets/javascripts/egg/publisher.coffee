class egg.Publisher

  constructor: ->
    @subscriptions = {}
  
  emit: (eventName, arg={}, sender)->
    event = {arg: arg, name: event, sender: sender}
    @runCallbacks(eventName, event)
    @runCallbacks('*', event)
    
  on: (event, callback, filter)->
    @subscriptions[event] ?= []
    @subscriptions[event].push callback: callback, filter: filter

  runCallbacks: (channel, e)->
    if @subscriptions[channel]
      for s in @subscriptions[channel]
        s.callback.call(e.sender, e.arg, e.name, e.sender) if !s.filter or s.filter(e)


egg.publisher = new egg.Publisher
