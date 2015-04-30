//= require utils/parsley_setup
//= require parsley
//= require utils/parsley-init
//= require jquery_fileupload/jquery.fileupload
//= require jquery_fileupload/jquery.fileupload-process
//= require jquery_fileupload/jquery.fileupload-validate
//= require jquery_fileupload/jquery.iframe-transport
//= require jquery_fileupload/jquery.ui.widget
//= require jquery/jquery.Jcrop.min
//= require utils/jcrop_setup
//= require tinymce

(function($) {
  $(function () {
    var $gigPhoto = $('.create-event');
    var $photoButton = $gigPhoto.find('button');
    var $crop_progress = $('#crop-progress');
    var $count_bar = $crop_progress.find('.countBar');
    var $line_bar = $crop_progress.find('.lineBar');
    var questionsCount = $('textarea[id$=_question]').length;
    var $faq = $('#faq').contents(),
      $foto = $('#photo_url');


    tinymce.init({ selector: '.editor' });

    if ($foto.val()) {
      $gigPhoto.backstretch($foto.val());
    }

    function clearPhotoDiv(){
      $gigPhoto.find('.fa-picture-o').remove();
      $gigPhoto.find('.create-event-text').remove();
    }

    function imageProcessingError(){
      $gigPhoto.addClass('has-error');
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
        var progress = data.loaded / data.total * 100;

        $count_bar.html(progress + '%');
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
            $gigPhoto.backstretch(photo_url);
            var $simpleForm = $('.simple_form');
            $simpleForm.find('[name="gig[photo_id]"]').val(response.photo.id);
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
      if (e.$element.is("textarea")) {
        e.$element.html(tinymce.get(e.$element.attr('id')).getContent());
      }
    });

    $('#upload-button').on('click', function(e){
      e.preventDefault();
      $('#upload').click();
    });

    $('#gig_price').maskMoney({
      thousands: '',
      decimal: '.',
      allowZero: true,
      suffix: ' $'
    });

    function addFaqQuestion(num){
      var $faq_question = $faq.clone();

      _.each(['question', 'answer'], function(field){
        var id = 'gig_faqs_attributes_' + num + '_' + field;
        var $field = $faq_question.find('#' + field);
        $field.addClass('.editor').attr({
          id: id,
          name: 'gig[faqs_attributes][' + num + '][' + field + ']'
        });
        $field.parents('.row').insertBefore('.addQuestion');
        tinyMCE.execCommand('mceAddEditor', true, id);
      });
    }

    $(document).on('click', '.addQuestion', function(e){
      e.preventDefault();
      questionsCount = $('textarea[id$=question]').length - 1;
      addFaqQuestion(questionsCount);
    });
  });
})(jQuery);
