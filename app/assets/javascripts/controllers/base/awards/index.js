(function($) {
  $(function() {
    var $form = $('#awards-form');

    $('body').on('click', 'a.delete-awards', function(e) {
      e.preventDefault();
      $form.submit();
    })
  });
})(jQuery);
