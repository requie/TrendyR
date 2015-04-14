(function($) {
  $(function() {
    var cropUtils = window.utils.crop;

    var photoUpload = function(selector, options) {
      this.$el = $(selector);
      this._init(options);
    };

    photoUpload.prototype = {
      $el: null,
      defaultOptions: {
        url: Routes.photos_path(),
        dataType: ' json',
        singleFileUploads: true,
        multipart: true,
        autoUpload: true,
        acceptFileTypes: /(\.|\/)(jpe?g|png)$/i,
        maxNumberOfFiles: 1
      },
      _init: function(options) {
        var cropOptions = options.crop || {};
        this.$el.fileupload(this.defaultOptions)
          .bind('fileuploaddone', function(e, data) {
            var photo = data.result.photo;
            cropUtils.init(_.extend({
              photo_id: photo.id,
              preset: 'avatar',
              $cropForm: $('#crop-container'),
              done: function(response, status, jqXHR){},
              fail: function(response, status, jqXHR){}
            }, cropOptions));
            cropUtils.show({
              photo_url: photo.url,
              trueSize: [photo.width, photo.height],
              boxWidth: 640,
              boxHeight: 480,
              aspectRatio: 1
            });
          });
      }
    };

    window.utils.photoUpload = photoUpload;
  });
})(jQuery);
