(function($) {
  $(function(){
    var $profile = $('.profile'),
      profileId = $('.custom-form').data('profile-id');

    $('body').on('click', '.gallerySettings .icon-deleteGallery', function(e) {
      e.preventDefault();
      var $checked = $(':checkbox:checked');
      var photo_album_ids = $checked.map(function() {
        return $(this).val();
      }).get();
      $.ajax({
        url: Routes.base_profile_gallery_path(profileId),
        dataType: 'json',
        type: 'DELETE',
        data: {
          photo_album_ids: photo_album_ids,
          page: $.urlParam('page')
        },
        success: function(response){
          window.location.reload();
        }
      });
    });

  });
})(jQuery);
