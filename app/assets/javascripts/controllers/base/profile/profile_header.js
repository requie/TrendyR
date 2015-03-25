(function($) {
  $(function(){
    var $wallpaper = $('.profile-public');
    $wallpaper.backstretch($wallpaper.find('[name=background-image]').val());
  });
})(jQuery);