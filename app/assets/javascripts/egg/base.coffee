class egg.Base

  @include: (obj)->
    Object.extend @::, obj

  @extend: (obj)->
    Object.extend @, obj
  
  @use: (plugin, args...)->
    plugin(@, args...)
  
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

  @init: (callback)->
    @on 'init', (opts, instance)->
      callback.call(instance, opts)
    
  constructor: (opts={})->
    @emit('init', opts)
