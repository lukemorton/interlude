// A safe setInterval Alternative
// Written by Luke Morton and Richard Willis, MIT licensed.
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  (function(definition) {
    if ((typeof module !== "undefined" && module !== null ? module.exports : void 0) != null) {
      return module.exports = definition();
    } else if (typeof define === 'function' && (define.amd != null)) {
      return define(definition);
    } else {
      return this.Interlude = definition();
    }
  })(function($) {
    return (function() {

      _Class.async = function(wait, fn) {
        var interval;
        interval = new Interlude(wait, fn);
        interval.isAsync = true;
        return interval;
      };

      _Class.prototype.isAsync = false;

      function _Class(wait, fn) {
        this.wait = wait != null ? wait : 1000;
        this.fn = fn;
        this.callback = __bind(this.callback, this);
        this.init();
      }

      _Class.prototype.init = function() {
        this.timeout = setTimeout(this.callback, this.wait);
        return this;
      };

      _Class.prototype.callback = function() {
        this.fn.call(this);
        if (!this.isAsync) this.timeout = setTimeout(arguments.callee, this.wait);
        return this;
      };

      _Class.prototype.next = function() {
        if (!this.isAsync) throw 'Interlude not async';
        this.init();
        return this;
      };

      _Class.prototype.stop = function() {
        clearTimeout(this.timeout);
        return this;
      };

      return _Class;

    })();
  });

}).call(this);
