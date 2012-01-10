class egg.Publisher

  constructor: ->
    @observers = {}
    @subscriptions = {}
    @objSubscriptions = {}
  
  emit: (eventName, arg, sender)=>
    event = {arg: arg, name: eventName, sender: sender}
    if sender
      @runObserverCallbacks(event)
      @runCallbacks(@objSubscriptions[sender.__eventsID]?[eventName], event)
      @runCallbacks(@objSubscriptions[sender.__eventsID]?['*'], event)
    @runCallbacks(@subscriptions[eventName], event)
    @runCallbacks(@subscriptions['*'], event)
    
  on: (eventName, callback, filter, sender)=>
    if sender
      throw("Can't subscribe to instance of #{sender.constructor.name} because it needs an __eventsID") unless sender.__eventsID
      @objSubscriptions[sender.__eventsID] ?= {}
      @objSubscriptions[sender.__eventsID][eventName] ?= []
      @objSubscriptions[sender.__eventsID][eventName].push callback: callback, filter: filter
    else
      @subscriptions[eventName] ?= []
      @subscriptions[eventName].push callback: callback, filter: filter

  observe: (constructor, objects...)=>
    @observers[constructor.name] = Object.extend({}, objects...)

  runObserverCallbacks: (e)->
    observer = @observers[e.sender.constructor.name]
    observer?[e.name]?.call(e.sender, e.arg, e.name, e.sender)

  runCallbacks: (callbacks, e)->
    if callbacks
      for s in callbacks
        s.callback.call(e.sender, e.arg, e.name, e.sender) if !s.filter or s.filter(e)

egg.publisher = new egg.Publisher
egg.emit = egg.publisher.emit
egg.on = egg.publisher.on
egg.observe = egg.publisher.observe
