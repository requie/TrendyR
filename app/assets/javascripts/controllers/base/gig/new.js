(function($) {
  $(function () {
    var $gigPhoto = $('.create-event');
    var $photoButton = $gigPhoto.find('button');
    var $crop_progress = $('#crop-progress');
    var $count_bar = $crop_progress.find('.countBar');
    var $line_bar = $crop_progress.find('.lineBar');
    var questionsCount = $('textarea[id$=_question]').length;
    var $faq = $('#faq').contents();

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
      if (e.$element.prop('type') == 'textarea') {
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
      var question_id = 'gig_faqs_attributes_'+num+'_question',
          answer_id = 'gig_faqs_attributes_'+num+'_answer';
      $faq_question.find('#question').addClass('.editor').attr({
        id: question_id,
        name: 'gig[faqs_attributes]['+num+'][question]'
      });
      $faq_question.find('#answer').addClass('.editor').attr({
        id: answer_id,
        name: 'gig[faqs_attributes]['+num+'][answer]'
      });
      $faq_question.insertBefore('.addQuestion');

      tinyMCE.execCommand('mceAddEditor', true, question_id);
      tinyMCE.execCommand('mceAddEditor', true, answer_id);
    }

    if(!questionsCount) {
      addFaqQuestion(0);
    }

    $(document).on('click', '.addQuestion', function(e){
      e.preventDefault();
      questionsCount = $('textarea[id$=question]').length-1;
      addFaqQuestion(questionsCount);
    })
  });
})(jQuery);