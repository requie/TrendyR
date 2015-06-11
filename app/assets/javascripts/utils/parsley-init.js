(function() {
  $(function() {
    $.listen('parsley:field:success', function(e) {
      if (e.$element.is(':checkbox')) {
        e.$element.closest('.cb-checkbox').removeClass('error-border');
      } else {
        e.$element.closest('.form-group').find('input, select, .mce-tinymce, textarea').removeClass('error-border');
      }
    });

    $.listen('parsley:field:error', function(e) {
      if (e.$element.is(':checkbox')) {
        e.$element.closest('.cb-checkbox').addClass('error-border');
      } else {
        e.$element.closest('.form-group').find('input, select, .mce-tinymce, textarea').addClass('error-border');
      }
    });

    var $parsleyForm = $('.parsley-form');

    if ($parsleyForm.length) {
      $parsleyForm.parsley();
    }
  });
})(jQuery);
