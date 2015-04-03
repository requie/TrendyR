(function($) {
  $(function () {
    var $eventAvatar = $('.create-event');
    var $photoButton = $eventAvatar.find('button');
    var $crop_progress = $('#crop-progress');
    var $count_bar = $crop_progress.find('.countBar');
    var $line_bar = $crop_progress.find('.lineBar');

    function clearPhotoDiv(){
      $eventAvatar.find('.fa-picture-o').remove();
      $eventAvatar.find('.create-event-text').remove();
    }

    function imageProcessingError(){
      $eventAvatar.addClass('has-error');
      $photoButton.html('Upload error <i class="fa fa-remove"></i>');
      clearPhotoDiv();
    }

    $('#upload').fileupload({
      url: Routes.photos_path(),
      type: 'POST',
      dataType: ' json',
      singleFileUploads: true,
      multipart: true,
      autoUpload: true,
      acceptFileTypes: /(\.|\/)(jpe?g|png)$/i,
      maxNumberOfFiles: 1,
      send: function(e, data){
        $crop_progress.removeClass('hidden');
      },
      progress: function (e, data) {
        progress = data.loaded/data.total*100;

        $count_bar.html(progress+'%');
        $line_bar.attr('data-value', progress);
      },
      done: function(e, data){
        $crop_progress.addClass('hidden');
        var photo = data.result.photo;

        window.utils.crop.init({
          photo_id: photo.id,
          preset: 'event_photo',
          $cropForm: $('#crop-container'),
          done: function (response, status, jqXHR) {
            var photo_url = response.photo.url;
            clearPhotoDiv();
            $eventAvatar.backstretch(photo_url);
            var $simpleForm = $('.simple_form');
            $simpleForm.find('[name="event[photo_id]"]').val(response.photo.id);
          },
          fail: function (response, status, jqXHR) {
            imageProcessingError();
          }
        });

        window.utils.crop.show({
          photo_url: photo.url,
          trueSize: [photo.width, photo.height],
          boxWidth: 640,
          boxHeight: 480,
          aspectRatio: 1.5
        });
      },
      fail: function(e, data){
        $crop_progress.addClass('hidden');
        imageProcessingError();
      }
    });

    $.listen('parsley:field:validate', function(e){
      if (e.$element.prop('type') == 'textarea') {
        e.$element.html(tinymce.get(e.$element.attr('id')).getContent());
      }
    });

    $('#upload-button').on('click', function(e){
      e.preventDefault();
      $('#upload').click();
    });

    $('#event_price').maskMoney({
      thousands: '',
      decimal: '.',
      allowZero: true,
      suffix: ' $'
    });
  });
})(jQuery);
