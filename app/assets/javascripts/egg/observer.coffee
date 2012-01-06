Object.extend @egg,

  observers: {}

  observe: (constructor, objects...)->
    callbacks = Object.extend(objects...)
    for name, callback of callbacks
      egg.publisher.on name, callback, (sender) -> sender.constructor == constructor
    @observers[constructor.name] = callbacks
