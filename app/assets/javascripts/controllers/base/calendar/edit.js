(function($) {
  $(function(){
    var $profile = $('.profile');
    var profileId = $('.custom-form').data('profile-id');

    $('body').on('click', '.gallerySettings .icon-deleteGallery', function(e){
      e.preventDefault();
      var $checked = $(':checkbox:checked');
      var event_ids = $checked.map(function() {
        return $(this).val();
      }).get();
      $.ajax({
        url: Routes.base_profile_calendar_path(profileId),
        dataType: 'json',
        type: 'DELETE',
        data: {
          event_ids: event_ids,
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
