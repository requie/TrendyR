(function($) {
  $(function() {
    var $searchInput = $('#search'),
      $container = $('#search-results'),
      $strBlock = $('.strPage'),
      timeout = void(0),
      url = gon.resource ? Routes.resource_search_index_path(gon.resource) : Routes.search_index_path();

    $searchInput.on('input', function() {
      if (timeout) {
        return;
      }

      timeout = setTimeout(function() {
        var query = $searchInput.val();

        $.ajax({
          url: url,
          dataType: 'json',
          data: { q: query },
          success: function(response) {
            $container.html(response.template);
            resizeFooter($strBlock);
          },
          complete: function() {
            timeout = void(0);
          }
        })
      }, 500);
    });
  });
})(jQuery);
