(function($) {
  $(function(){
    var $profile = $('.profile');
    var profileId = $('[data-profile-id]').data('profile-id');

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
      var $checked = $(':checkbox:checked');
      var gig_ids = $checked.map(function() {
        return $(this).val();
      }).get();
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
          window.location.reload();
        }
      });
    });

  });
})(jQuery);
