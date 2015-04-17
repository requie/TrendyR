(function($) {
  $(function () {
    $.urlParam = function (name) {
      var results = new RegExp('[\?&]' + name + '=([^&#]*)').exec(decodeURIComponent(window.location.search));
      if (results == null) {
        return null;
      } else {
        return results[1] || 0;
      }
    }
  });
})(jQuery);
