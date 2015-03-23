(function($) {
  $(function(){

    var $body = $('body');
    var $profile = $('.profile');
    var $profileId = $('.custom-form').data('profile-id');

    function update_photo_albums(response){
      var $checkBoxWraper = '<label class="mobile-center cb-checkbox">';
      var $template = $('[data-gallery]');
      var $pagination = $profile.find('.pagination').parent();
      
      _.each(response, function(photo_album){
        var $element = $template.clone().removeClass('hidden').removeAttr('data-gallery');
        $element.find('[data-album-id]').wrap($checkBoxWraper).val(photo_album.id);
        $element.find('[data-first-photo-url]').attr('href',Routes.base_profile_photo_album_path(profile, photo_album));
        $element.find('[data-first-photo]').attr('src',photo_album.first_photo);
        $element.find('[data-album-title]').html(photo_album.title);
        $element.find('[data-created]').html(photo_album.date_of_creation);
        $element.find('[data-photos]').html(photo_album.number_of_photos);
        var $gallerySettings = $element.find('[data-gallery-settings]');
        var $miniGallery = $element.find('[data-remaining-photos]');
        _.each(photo_album.remaining_photos,function(photo){
          $('<img>').attr('src',photo).appendTo($miniGallery);
        });
        $gallerySettings.find('[data-change-album]').attr('href',Routes.edit_base_profile_photo_album_path($profileId,photo_album))
        $element.insertBefore($pagination);
        $element.checkBo();
      });
    }

    $body.on('click','.gallerySettings .icon-deleteGallery', function(e){
      e.preventDefault();
      var $checked = $('.settingVis input');
      $checked.each(function(){
        $.ajax({
          url: Routes.base_profile_photo_album_path($profileId,$(this).val()),
          dataType: 'json',
          type: 'DELETE',
          success: function(response){
            $profile.find('.gallery').remove();
            $('.static-content span').html('('+response.length+')');
            update_photo_albums(response);
          }
        });
        var $parent_div = $(this).parents('.settingVis');
        $($parent_div).fadeOut(function(){
          $parent_div.remove();
        });
      });
    });

    $body.on('click','.cb-checkbox', function(){
      $(this).closest('.gallery').toggleClass('settingVis');
    })
    .checkBo();
  });
})(jQuery);
