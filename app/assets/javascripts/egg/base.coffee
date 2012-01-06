class egg.Base

  @include: (obj)->
    Object.extend @::, obj

  @extend: (obj)->
    Object.extend @, obj
  
  @include egg.Events

  constructor: (opts={})->
    @init(opts) if @init
    @emit('init', opts)
