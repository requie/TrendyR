(function($) {
  $(function() {
    var $table = $('.message-list');

    $table.on('click', '.nameMessage', function(e) {
      e.preventDefault();
      var url = this.getAttribute('data-url');
      location.href = url;
    });
  });
})(jQuery);
