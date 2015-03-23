(function($) {
  $(function(){
    $('.gallerySettings').on('click','.icon-deleteGallery', function(e){
      e.preventDefault();
      var $checked = $('.settingVis input');
      var $profileId = $('.custom-form').data('profile-id');
      $checked.each(function(){
        $.ajax({
          url: Routes.base_profile_photo_album_path($profileId,$(this).val()),
          dataType: 'json',
          type: 'DELETE',
          success: function(response){
            $('.profile .gallery').remove();
            response.forEach(function(photo_album){
              $('.static-content span').html('('+response.length+')');
              var $element = $('[data-gallery]').clone();
              var $checkBox = $element.find('[data-album-id]');
              $checkBox.wrap('<label class="mobile-center cb-checkbox">').val(photo_album.id);
              $element.find('[data-first-photo-url]').attr('href',Routes.base_profile_photo_album_path(profile, photo_album));
              $element.find('[data-first-photo]').attr('src',photo_album.first_photo);
              $element.find('[data-album-title]').html(photo_album.title);
              $element.find('[data-created]').html(photo_album.date_of_creation);
              $element.find('[data-photos]').html(photo_album.number_of_photos);
              var $gallerySettings = $element.find('[data-gallery-settings]');
              var $miniGallery = $element.find('[data-remaining-photos]');
              photo_album.remaining_photos.forEach(function(photo){
                $('<img>').attr('src',photo).appendTo($miniGallery);
              });
              $gallerySettings.find('[data-change-album]').attr('href',Routes.edit_base_profile_photo_album_path($profileId,photo_album))
              $element.removeClass('hidden').removeAttr('data-gallery');
              if($(".profile .pagination").length) {
                $element.insertBefore('.pagination');
              }
              else {
                $element.appendTo('.profile');
              }
              $element.checkBo();
            });
            $('.cb-checkbox').click(function(){
              $(this).closest('.gallery').toggleClass('settingVis');
            });
          }
        });
        var $parent_div = $(this).parents('.settingVis');
        $($parent_div).fadeOut(function(){
          $parent_div.remove();
        });
      });
    });
  });
})(jQuery);
