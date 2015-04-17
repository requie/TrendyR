(function($) {
  $(function(){
    $('body').on('click', '.link, .error_text', function(e){
      e.preventDefault();

      var $parent_div = $(this).parents('li');
      var $confirmation = $(this).parents('.confirmation');
      $.ajax({
        url: $(this).attr('href'),
        type: 'PUT',
        data: {
          status: $(this).data('status')
        },
        success: function(){
          $parent_div.remove();
          var requestsCount = $confirmation.find('.confirmation_list_point').length;
          if (requestsCount == 0) {
            $confirmation.hide();
          }
        }
      });
    })
    .on('click', '.gallerySettings .icon-deleteGallery', function(e){
      e.preventDefault();
      $('.custom-form form').submit();
    });

  });
})(jQuery);
