//= require audio/audio
//= require audio/player

(function($) {
  $(function () {
    $('.btn-play').click(function(e){
      $('.play:first').click();
    })
  });
})(jQuery);
