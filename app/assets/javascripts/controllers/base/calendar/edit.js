(function($) {
  $(function(){
    var $profile = $('.profile');
    var profileId = $('.custom-form').data('profile-id');
    var $checkBoxWrapper = '<label class="mobile-center cb-checkbox">';
    var $template = $('[data-gallery]');
    var $pagination = $profile.find('.pagination').parent();

    function updateEvents(response){
      _.each(response, function(event){
        var $element = $template.clone().removeClass('hidden').removeAttr('data-gallery');
        $element.find('[data-event-id]').wrap($checkBoxWrapper).val(event.id);
        $element.find('[data-event-photo]').attr('src', event.photo);
        $element.find('[data-event-title]').html(event.title);
        $element.find('[data-event-period]').html(event.period);
        $element.find('[data-event-location]').html(event.location);
        $element.find('[data-event-price]').html(event.price);
        var $gallerySettings = $element.find('[data-gallery-settings]');
        $gallerySettings.find('[data-event-edit]').attr('href', Routes.edit_base_profile_event_path(profileId, event))
        var $status = $element.find('[data-event-status]');
        $status.find('i').addClass("icon-"+event.status);
        $status.find('p').addClass("galleryStatus_"+event.status).html(event.status);
        $element.insertBefore($pagination);
        $element.checkBo();
      });
    }

    $('body').on('click', '.gallerySettings .icon-deleteGallery', function(e){
      e.preventDefault();
      var $checked = $(':checkbox:checked');
      var event_ids = $checked.map(function() {
        return $(this).val();
      }).get();
      $checked.parents('.gallery').remove();
      $.ajax({
        url: Routes.base_profile_destroy_events_path(profileId),
        dataType: 'json',
        type: 'DELETE',
        data: {
          event_ids: event_ids,
          page: $.urlParam('page'),
          filter: $.urlParam('filter')
        },
        success: function(response){
          $profile.find('.gallery').remove();
          $('.static-content span').html('('+response.length+')');
          updateEvents(response);
        }
      });
    });
  });
})(jQuery);
