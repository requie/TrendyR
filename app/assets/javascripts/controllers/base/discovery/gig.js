//= require jquery/jquery.infinitescroll

(function($) {
  $(function() {
    var path = Routes.events_base_profile_discovery_index_path(),
      imgLoader = '/assets/loading.gif',
      msgTemplate = $('<div class="text-center p-tb20"><img alt="Loading" src="' + imgLoader + '"></div>');

    $('.all-content .music-block').infinitescroll({
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
        return [path, '?page=', page].join('');
      }
    });

    $('body').on('click', 'a.request', function(e) {
      e.preventDefault();
      var $this = $(this);
      $.ajax({
        url: $this.attr('href'),
        type: 'POST',
        success: function() {
          $this.parent().remove();
        }
      })
    })
  });
})(jQuery);
