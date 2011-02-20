(function($) {    
    $.event.special.edit = {
        setup: function(data) {
          if(this.addEventListener){// Firefox, Opera, Google Chrome and Safari
             // for older Google Chrome and Safari should use textInput event...but...
            $(this).bind("input", function(e){
              $(this).trigger("edit");              
            });
          }

          //IE
          if(this.onpropertychange!==undefined){
            $(this).bind("propertychange", function(e){
              if (event.propertyName.toLowerCase() == "value") {
                $(this).trigger("edit");              
              }
            });

          }

          return true;
            
        },
        teardown: function () {
          alert('warning! teardown nt implemented yet!');
          return true;
        }
    };

    // Setup our jQuery shorthand method
    $.fn.edit = function (handler) {
        return handler ? this.bind("edit", handler) : this.trigger("edit");
    }
    
})(jQuery);
