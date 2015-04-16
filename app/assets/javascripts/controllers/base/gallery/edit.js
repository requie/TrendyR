(function($) {
  $(function(){
    var $form = $('.custom-form form');

    $('body').on('click', '.gallerySettings .icon-deleteGallery', function(e) {
      e.preventDefault();
      $form.submit();
    });
  });
})(jQuery);
