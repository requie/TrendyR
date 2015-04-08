(function($) {
  $(function(){


    $('body').on('click', '.link, .error_text', function(e){
      e.preventDefault();
      var requestId = $(this).data('request-id');
      var status = $(this).data('status');

      $.ajax({
        url: Routes.base_set_request_status_path(requestId),
        type: 'PUT',
        data: {
          status: status
        },
        success: function(response){
          $profile.find('.gallery').remove();
          $('.static-content span').html('('+response.length+')');
          updatePhotoAlbums(response);
        }
      });
    });

  });
})(jQuery);
