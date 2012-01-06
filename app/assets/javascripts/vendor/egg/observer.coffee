Object.extend @egg,

  observers: {}

  observe: (constructor, args...)->
    if args.length == 1
      opts = {}
      callbacks = args[0]
    else
      [opts, callbacks] = args
    if opts.include
      callbacks = Object.extend({}, @observers[opts.include.name], callbacks)
      console.log callbacks
    for name, callback of callbacks
      egg.publisher.on name, callback, (sender) -> sender.constructor == constructor
    @observers[constructor.name] = callbacks
