(function($) {
    window.ParsleyConfig = {
      namespace: 'data-',
      errorsWrapper: '<div class="error-message"></div>',
      errorTemplate: '<span></span>',
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
        minLengthIfNotEmpty: {
          fn: function(value, requirement) {
            if(value) return value.length >= requirement;
            else return true;
          }
        }
      }
    };
})(jQuery);