(function($) {
  $(function () {
    var $eventAvatar = $('.create-event');

    function clearPhotoDiv(){
      $eventAvatar.find('.fa-picture-o').remove();
      $eventAvatar.find('.create-event-text').remove();
    }

    function ImageProcessingError(){
      $eventAvatar.addClass('has-error');
      $eventAvatar.find('button').html('Upload error <i class="fa fa-remove"></i>');
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
      send: function (e, data) {

      },
      progress: function(e, data){

      },
      done: function(e, data){
        var photo = data.result.photo;

        window.utils.crop.init({
          photo_id: photo.id,
          $cropForm: $('#crop-container'),
          done: function (response, status, jqXHR) {
            var photo_url = response.photo.url;
            clearPhotoDiv();
            $eventAvatar.backstretch(photo_url);
            var $simpleForm = $('.simple_form');
            $simpleForm.find('[name="event[photo_id]"]').val(response.photo.id);
          },
          fail: function (response, status, jqXHR) {
            ImageProcessingError();
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
        ImageProcessingError();
      }
    });

    $.listen('parsley:field:validate', function(e){
      if (e.$element.prop('type') == 'textarea') e.$element.html(tinymce.get(e.$element.attr('id')).getContent());
    });

    $('#upload-button').on('click', function(e){
      e.preventDefault();
      $('#upload').click();
    });

    $('#event_price').maskMoney({thousands:'', decimal:'.', allowZero:true, suffix: ' $'});
  });
})(jQuery);