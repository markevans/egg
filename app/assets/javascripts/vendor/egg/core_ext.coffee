Object.extend = (obj, otherObjs...)->
  for otherObj in otherObjs
    obj[key] = value for key, value of otherObj
  obj
