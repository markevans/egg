class egg.Base

  @include: (obj)->
    Object.extend @::, obj

  @extend: (obj)->
    Object.extend @, obj
  
  @use: (plugin)->
    plugin(@)
  
  @use egg.Events

  @parentClass: ->
    @__super__?.constructor
  
  @ancestors: ->
    @_ancestors ?= (
      parent = @parentClass()
      if parent
        [@].concat parent.ancestors()
      else
        [@]
    )
    
  constructor: (opts={})->
    @init(opts) if @init
    @emit('init', opts)
