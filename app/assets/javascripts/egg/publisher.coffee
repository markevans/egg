class egg.Publisher

  constructor: ->
    @globalChannel = {}
    @channels = {}
  
  emit: (eventName, arg, sender)=>
    event = {arg: arg, name: eventName, sender: sender}
    if sender
      @runChannelCallbacks(@channels[sender.eventsID()], eventName, event)
      if sender.classAncestors
        for klass in sender.classAncestors()
          @runChannelCallbacks(@channels[klass.eventsID()], eventName, event)
    @runChannelCallbacks(@globalChannel, eventName, event)
    
  on: (eventName, callback, filter, sender)=>
    if sender
      throw("Can't subscribe to instance of #{sender.constructor.name} because it needs an eventsID") unless sender.eventsID()
      @channels[sender.eventsID()] ?= {}
      @subscribe(@channels[sender.eventsID()], eventName, callback, filter)
    else
      @subscribe(@globalChannel, eventName, callback, filter)
  
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
        s.callback.call(e.sender, e.arg, e.name, e.sender) if !s.filter or s.filter(e)

egg.publisher = new egg.Publisher
egg.emit = egg.publisher.emit
egg.on = egg.publisher.on
