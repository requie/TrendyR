//= require audio/audio
//= require audio/player

(function($) {
  $(function () {
    $('[data-th="Action"]').on('click', '.red', function(e){
      e.preventDefault();/*
      var $row = $(this).parents('tr');
      $.ajax({
        url: Routes.song_path($row.data('songId')),
        type: 'DELETE',
        success: function(){
          $row.remove();
        }
      })*/
    })
    .on('click', '.publish', function(e){
      e.preventDefault();
      var $row = $(this).parents('tr');
      var $that = $(this);
      $.ajax({
        url: $(this).attr('href'),
        type: 'PUT',
        success: function(){
          $that.attr('class', 'color_blue unpublish').html('Unpublish');
        }
      })
    })
    .on('click', '.unpublish', function(e){
      e.preventDefault();
      var $row = $(this).parents('tr');
      var $that = $(this);
      $.ajax({
        url: $(this).attr('href'),
        type: 'PUT',
        success: function(){
          $that.attr('class', 'color_green publish').html('Publish');
        }
      })
    });

    $("#search").on('keypress', 'input[type="text"]', function(event) {
      if (event.which == 13) {
        event.preventDefault();
        $("#search").submit();
      }
    });
  });
})(jQuery);

