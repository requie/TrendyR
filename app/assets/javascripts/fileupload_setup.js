(function($) {
  $(function() {

    // ! ATTENTION: some weird things with the previewbox if aspect ratio != 1
    // it should be fixed or previewbox should be removed

    var preset = 'user_avatar';

    var $uploadForm = $('#fileupload');
    var $avatarImg = $uploadForm.find('.new-avatar img');

    var $avatarId = $('.user-user_avatar-id');

    var cropUtils = window.crop;

    var $progressModal = $('.upload-main');
    var $progressPercentCount = $('.download-counter');
    var $progressVisual = $('.process-upload')

    $uploadForm.fileupload({
      url: Routes.images_path(preset),
      dataType:' json',
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
      done: function(ev, data) {
        $progressModal.modal('hide');
        cropUtils.show(data.result);
      },
      fail: function(ev, data) {
        console.error(ev, data);
      },
      processfail: function(ev, data) {
        console.error(ev, data);
        var error = data.files[0].error;
        window.alert(error);
      },
      start: function(ev, data) {
        $progressModal.modal();
      },
      progressall: function(ev, data) {
        var progress = 0.9 * parseInt(data.loaded / data.total * 100, 10);
        //leave 10% for fake process file
        if (progress < 90) {
          $progressVisual.css('width', progress + '%');
        } else {
          setTimeout(function(){
            var timeWait = data.total < 5000000 ? data.total / 1000 : 5000; // file about 5mb(1 mb/sec)
            var deltaTime = 200;
            var deltaProgress = 10 * deltaTime / timeWait; //10% left
            for(var delayTime = deltaTime; delayTime < timeWait; delayTime += deltaTime ){
              setTimeout(function(){
                progress += deltaProgress;
                $progressVisual.css('width', progress + '%');
                $progressPercentCount.html(parseInt(progress, 10) + '%');
              }, delayTime);
            }
            setTimeout(function(){
              $progressVisual.css('width', '100%');
              $progressPercentCount.html('Done');
            }, timeWait + 100);
          }, 100);
        }
      }
    });

    cropUtils.init({
      $modal: $('.modal.crop-img'),
      preset: preset,
      done: function(response, status, jqXHR) {
        $avatarId.val(response.id);
        $avatarImg.prop('src', response.user_avatar_url);
        $avatarImg.parent().removeClass('error');
      },
      fail: function(jqXHR, textStatus, errorThrown) {
        console.error(jqXHR, textStatus, errorThrown);
      }
    });

  });
})(jQuery);
