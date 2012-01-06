class egg.Publisher

  constructor: ->
    @observers = {}
    @subscriptions = {}
  
  emit: (eventName, arg={}, sender)->
    event = {arg: arg, name: eventName, sender: sender}
    @runObserverCallbacks(event)
    @runCallbacks(eventName, event)
    @runCallbacks('*', event)
    
  on: (event, callback, filter)->
    @subscriptions[event] ?= []
    @subscriptions[event].push callback: callback, filter: filter

  runObserverCallbacks: (e)->
    observer = @observers[e.sender.constructor.name]
    observer?[e.name]?.call(e.sender, e.arg, e.name, e.sender)

  runCallbacks: (channel, e)->
    if @subscriptions[channel]
      for s in @subscriptions[channel]
        s.callback.call(e.sender, e.arg, e.name, e.sender) if !s.filter or s.filter(e)

egg.publisher = new egg.Publisher
egg.observe = (constructor, objects...)->
  @publisher.observers[constructor.name] = Object.extend({}, objects...)
