(function($) {
  $(function () {
    var $eventAvatar = $('.create-event');
    $eventAvatar.find('.fa-picture-o').remove();
    $eventAvatar.find('.create-event-text').remove();
    $eventAvatar.backstretch($('#photo_url').val());
  });
})(jQuery);
