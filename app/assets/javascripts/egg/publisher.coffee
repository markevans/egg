ancestorChain = (obj)->
  if obj.constructor.ancestors then [obj, obj.constructor.ancestors()...] else [obj]

class egg.Publisher

  constructor: ->
    @globalChannel = {}
    @channels = {}
    @observers = {}
  
  emit: (eventName, arg, sender)=>
    event = {arg: arg, name: eventName, sender: sender}
    if sender
      for obj in ancestorChain(sender)
        break if @runObserverCallback(@observers[obj.eventsID()], eventName, event)
      for obj in ancestorChain(sender)
        @runChannelCallbacks(@channels[obj.eventsID()], eventName, event)
    @runChannelCallbacks(@globalChannel, eventName, event)
    
  on: (eventName, callback, filter, sender)=>
    if sender
      @channels[sender.eventsID()] ?= {}
      @subscribe(@channels[sender.eventsID()], eventName, callback, filter)
    else
      @subscribe(@globalChannel, eventName, callback, filter)
  
  observe: (eventName, callback, sender)=>
    @observers[sender.eventsID()] ?= {}
    @observers[sender.eventsID()][eventName] = callback
  
  subscribe: (channel, eventName, callback, filter)->
    channel[eventName] ?= []
    channel[eventName].push callback: callback, filter: filter

  runChannelCallbacks: (channel, eventName, event)->
    if channel
      @runCallbacks(channel[eventName], event)
      @runCallbacks(channel['*'], event)

  runCallbacks: (callbacks, e)->
    if callbacks
      for s in callbacks
        s.callback(e.arg, e.sender, e.name) if !s.filter or s.filter(e)

  runObserverCallback: (channel, eventName, e)->
    if channel && channel[eventName] != undefined
      channel[eventName](e.arg, e.sender, e.name) unless channel[eventName] == null
      true
    else
      false
    
egg.publisher = new egg.Publisher
egg.emit = egg.publisher.emit
egg.on = egg.publisher.on
