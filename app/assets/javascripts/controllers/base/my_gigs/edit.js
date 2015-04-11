(function($) {
  $(function(){
    var profileId = $('[data-profile-id]').data('profile-id');
    var $checkBoxWrapper = '<label class="mobile-center cb-checkbox">';
    var $template = $('[data-gallery]');
    var $pagination = $('.pagination').parent();

    function updateGigs(response){
      _.each(response, function(gig){
        var $element = $template.clone().removeClass('hidden').removeAttr('data-gallery');
        $element.find('[data-gig-id]').wrap($checkBoxWrapper).val(gig.id);
        $element.find('[data-gig-photo]').attr('src', gig.photo);
        $element.find('[data-gig-title]').html(gig.title);
        $element.find('[data-gig-period]').html(gig.period);
        $element.find('[data-gig-address]').html(gig.address);
        $element.find('[data-gig-price]').html(gig.price);
        $element.find('[data-gig-address]').html(gig.address);
        var $gallerySettings = $element.find('[data-gallery-settings]');
        var $miniGallery = $element.find('[data-remaining-photos]');
        _.each(photo_album.remaining_photos, function(photo){
          $('<img>').attr('src', photo).appendTo($miniGallery);
        });
        $gallerySettings.find('[data-change-album]').attr('href', Routes.edit_base_profile_photo_album_path(profileId, photo_album))
        $element.insertBefore($pagination);
        $element.checkBo();
      });
    }

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
    })
    .on('click', '.gallerySettings .icon-deleteGallery', function(e){
      e.preventDefault();
      var $checked = $(':checkbox:checked');
      var gig_ids = $checked.map(function() {
        return $(this).val();
      }).get();
      $checked.parents('.gallery').remove();
      $.ajax({
        url: Routes.base_profile_my_gigs_path(profileId),
        dataType: 'json',
        type: 'DELETE',
        data: {
          gig_ids: gig_ids,
          page: $.urlParam('page'),
          filter: $.urlParam('filter')
        },
        success: function(response){
          $profile.find('.gallery').remove();
          $('.static-content span').html('('+response.length+')');
          updateGigs(response);
        }
      });
    });

  });
})(jQuery);
