(function($) {
    window.ParsleyConfig = {
      namespace: 'data-',
      errorsWrapper: '<div class="error-message"></div>',
      errorTemplate: '<span></span>',
      validators: {
        allconnectionsclosed: {
          fn: function (value, requirement) {
            return 0 === jQuery.active;
          },
          priority: 32
        },
        minonephoto: {
          fn: function(value, requirement) {
            return $('.editPicture:not(.hidden)').length > 0
          }
        }

      }
    };
})(jQuery);