//= require jquery/jquery.infinitescroll

(function($) {
  $(function() {
    var type = location.pathname.split('/').pop(),
      path = Routes.discovery_index_path(type),
      imgLoader = '/assets/loading.gif',
      msgTemplate = $('<div class="text-center p-tb20"><img alt="Loading" src="' + imgLoader + '"></div>'),
      $root;

    if (type === 'venue') {
      $root = $('.all-content .music-block');
    } else {
      $root = $('.music-block table tbody');
      $('#root').on('click', 'td.nameArtist', function(e) {
        e.preventDefault();
        var url = $(this).parents('tr').attr('data-url');
        location.href = url;
      });
    }

    $root.infinitescroll({
      debug: false,
      loading: {
        finishedMsg: '',
        selector: '.infinite-loader',
        speed: '_default',
        img: imgLoader,
        msg: msgTemplate
      },
      appendCallback: true,
      template: function (response) {
        return response.template;
      },
      navSelector: '#footer',
      dataType: 'json',
      path: function(page) {
        var params = _.defaults({ page: page }, gon.q || {});
        return [path, '?', $.param(params)].join('');
      }
    });
  });
})(jQuery);
