(function($) {
  $(function(){
    $('body').on('click', '.gallerySettings .icon-deleteGallery', function(e) {
      e.preventDefault();
      $('.custom-form form').submit();
    });

  });
})(jQuery);
