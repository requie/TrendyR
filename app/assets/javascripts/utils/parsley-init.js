(function() {
  $(function() {
    $.listen('parsley:field:success', function(e) {
      e.$element.closest('.form-group').find('input, select, .mce-tinymce, textarea').removeClass('error-border');
    });

    $.listen('parsley:field:error', function(e) {
      e.$element.closest('.form-group').find('input, select, .mce-tinymce, textarea').addClass('error-border');
    });

    var $parsleyForm = $('.parsley-form');

    if ($parsleyForm.length) {
      $parsleyForm.parsley();
    }
  });
})(jQuery);
