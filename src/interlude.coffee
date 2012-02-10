# A safe setInterval Alternative
# Written by Luke Morton and Richard Willis, MIT licensed.
#
# Usage:
#    // A JavaScript example
#    var interval = new Interlude(500, function () {
#         console.log('bob');
#    });
#    interval.stop();
#
#    # A CoffeeScript example
#    new Interlude 500, ->
#      # @ or this represents the Interlude instance
#      console.log 'bob'
#      @count or= 0
#      if @count++ is 5 then @stop()
#
#    # Asynchronous interval
#    Interlude.async 1500, ->
#      $.get('/test', => @next())
#
((definition) ->
  if module?.exports? then module.exports = definition();
  else if typeof define is 'function' and define.amd? then define(definition)
  else @Interlude = definition()
) ($) -> 
  return class
    @async: (wait, fn) ->
      interval = new Interlude(wait, fn)
      interval.isAsync = true
      return interval

    isAsync: false

    constructor: (@wait = 1000, @fn) -> @init()

    init: ->
      @timeout = setTimeout(@callback, @wait)
      return @

    callback: =>
      @fn.call(@)
      @timeout = setTimeout(arguments.callee, @wait) unless @isAsync
      return @

    next: ->
      throw 'Interlude not async' unless @isAsync
      @init()
      return @
    
    stop: () ->
      clearTimeout(@timeout)
      return @