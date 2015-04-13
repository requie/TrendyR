(function($) {
  $(function(){
    var $profile = $('.profile');
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
        var $gallerySettings = $element.find('[data-gallery-settings]');
        $gallerySettings.find('[data-gig-edit]').attr('href', Routes.edit_base_profile_gig_path(profileId, gig))
        var $miniGallery = $element.find('[data-remaining-photos]');
        _.each(gig.requests, function(photo){
          $('<img>').attr('src', photo).appendTo($miniGallery);
        });
        var $status = $element.find('[data-gig-status]');
        $status.find('i').addClass("icon-" + gig.status);
        $status.find('p').addClass("galleryStatus_" + gig.status).html(gig.status);
        $element.insertBefore($pagination);
        $element.checkBo();
      });
    }

    $('body').on('click', '.link, .error_text', function(e){
      var parent_div = $(this).parents('li');
      $.ajax({
        url: $(this).data('link'),
        type: 'PUT',
        success: function(){
          parent_div.hide();
        }
      });
      return false;
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
          updateGigs(response);
        }
      });
    });

  });
})(jQuery);
