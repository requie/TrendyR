(function($) {
  $(function() {


    var FileUpload = {
      init: function(){
        $uploadForm.fileupload({
          url: Routes.images_path(preset),
          dataType: ' json',
          singleFileUploads: true,
          multipart: true,
          autoUpload: true,
          processQueue: [{
            action: 'validate',
            always: true,
            acceptFileTypes: /(\.|\/)(jpg|jpeg)$/i,
            maxFileSize: 1024 * 1024 * 5, // 5 mb
            maxNumberOfFiles: 1
          }],
          done: function (ev, data) {
            $progressModal.modal('hide');
            cropUtils.show(data.result);
          },
          fail: function (ev, data) {
            console.error(ev, data);
          },
          processfail: function (ev, data) {
            console.error(ev, data);
            var error = data.files[0].error;
            window.alert(error);
          },
          start: function (ev, data) {
            $progressModal.modal();
          },
        });
      }
  }

  });
})(jQuery);
