#= require_tree ./observers

class @ClockApp
  
  constructor: (opts)->
    alert("started clock app on #{opts.el}")
