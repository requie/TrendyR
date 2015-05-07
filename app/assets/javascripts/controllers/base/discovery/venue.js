//= require jquery/jquery.infinitescroll

(function($) {
  $(function() {
    var path = Routes.venues_base_profile_discovery_index_path(),
      imgLoader = '/assets/loading.gif',
      msgTemplate = $('<div class="text-center p-tb20"><img alt="Loading" src="' + imgLoader + '"></div>');

    $('.all-content .music-block').infinitescroll({
      debug: true,
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
  });
})(jQuery);
