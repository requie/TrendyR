(function($) {
    window.ParsleyConfig = {
      namespace: 'data-',
      errorsWrapper: '<div class="error-message"></div>',
      errorTemplate: '<span></span>',
      excluded: 'input[type=button], input[type=submit], input[type=reset], input[type=hidden]',
      inputs: 'input, textarea, select',
      validators: {
        allConnectionsClosed: {
          fn: function (value, requirement) {
            return 0 === jQuery.active;
          },
          priority: 32
        },
        minOnePhoto: {
          fn: function(value, requirement) {
            return $('.editPicture:not(.hidden)').length > 0;
          }
        },
        existIfInputFilled: {
          fn: function(value, requirement) {
            if($(requirement).val()) {
              return Boolean(value);
            }
            return true
          }
        },
        anotherInputFilled: {
          fn: function(value, requirement) {
            return Boolean($(requirement).val());
          }
        },
        minLengthIfNotEmpty: {
          fn: function(value, requirement) {
            if(value) return value.length >= requirement;
            else return true;
          }
        }
      }
    };
})(jQuery);