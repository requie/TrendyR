(function($) {
  $(function() {
    $('body')
      .on('click', '.apply-booking', function(e) {
        e.preventDefault();
        var $this = $(this);
        $.ajax({
          url: $this.data('url'),
          method: 'PUT',
          success: function() {
            $this.parent().html($('<p class="p-t7">Applied</p>'));
          }
        });
      })
      .on('click', '.cancel-booking', function(e) {
        e.preventDefault();
        var $this = $(this);
        $.ajax({
          url: $this.attr('href'),
          method: 'PUT',
          success: function() {
            $this.parent().html($('<p class="p-t7">Canceled</p>'));
          }
        });
      });
  });
})(jQuery);
