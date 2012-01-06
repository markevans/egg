class egg.Base

  @include: (obj)->
    Object.extend @::, obj

  @extend: (obj)->
    Object.extend @, obj
  
  @include egg.Events

  constructor: (args={})->
    @init(args) if @init
    @emit('init', args)
