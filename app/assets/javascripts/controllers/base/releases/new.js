//= require parsley
//= require utils/parsley_setup
//= require utils/parsley-init
//= require jquery_fileupload/jquery.fileupload
//= require jquery_fileupload/jquery.fileupload-process
//= require jquery_fileupload/jquery.fileupload-validate
//= require jquery_fileupload/jquery.iframe-transport
//= require jquery_fileupload/jquery.ui.widget
//= require audio/audio
//= require audio/player
//= require audio/id3.min

(function($) {
  $(function () {
    var $songUpload = $('#song-upload'),
    $cover = $('#cover'),
    $audioList = $("#audio-list"),
    $audioDone = $("#audio-done"),
    $audioProgress = $("#audio-progress"),
    $audioAdded = $("#audio-added");

    $songUpload.fileupload({
      url: Routes.songs_path(),
      acceptFileTypes: /(\.|\/)(mp3|wav)$/i,
      maxFileSize: 10000000,
      limitMultiFileUploads: 2
    }).bind('fileuploadsend', function (e, data) {
      id3(data.files[0], function(err, tags){
        var title = data.files[0].name;
        if(tags){
          title = tags.title;
        }
        var $block = $audioAdded.clone().removeAttr('id');
        $block.find('[data-song-title]').html(title);
        data.context = $block.appendTo($audioList);
      });
    }).bind('fileuploadprogress', function(e, data){
      var progress = parseInt(data.loaded / data.total * 100, 10);
      var $context = data.context;
      if($context.attr('data-wait') && progress > 0){
        var $audioProgressTemplate = $audioProgress.clone().removeAttr('id');
        $context.removeAttr('data-wait').attr('data-progress', true).html($audioProgressTemplate.html());
      }

      if($context.attr('data-progress')){
        $context.find('.lineBar').data('value', progress).attr('data-value', progress);
        $context.find('.countBar').text(progress + "%");
      }
    }).bind('fileuploaddone', function(e, data){
      var $context = data.context;
      var title = $context.find('[data-song-title]');
      var $audioDoneTemplate = $audioDone.clone().removeAttr('id');
      $audioDoneTemplate.find('.audioTrack_link').attr('data-src', data.result.url).html(data.result.title);
      $audioDoneTemplate.find('[data-song-id]').val(data.result.id);
      $context.removeAttr('data-progress').html($audioDoneTemplate.html());
    }).bind('fileuploadprocessfail', function(e, data){
      console.log(data.files[0].error);
    });

    $audioList.on('click', 'a.red', function(e){
      e.preventDefault();
      $(this).parents('td').remove();
    });

    $('#image-upload').fileupload({
      url: Routes.photos_path(),
      dataType: 'json',
      acceptFileTypes: /(\.|\/)(jpe?g|png)$/i,
      maxFileSize: 10000000
    }).bind('fileuploadsend', function (e, data) {
      $cover.html($('#empty-progress').html());
    }).bind('fileuploadprogress', function(e, data){
      var progress = parseInt(data.loaded / data.total * 100, 10);
      $cover.find('.lineBar').attr('data-value', progress);
      $cover.find('.countBar').text(progress + "%");
    }).bind('fileuploaddone', function(e, data){
      var photo = data.result.photo;
      $cover.empty().backstretch(photo.url);
      $('#release_photo_id').val(photo.id);
    }).bind('fileuploadprocessfail', function(e, data){
      console.log(data.files[0].error);
    });
  });

  $.listen('parsley:field:error', function(e){
    if (e.$element.attr('id') == 'release_photo_id'){
      $('#cover').addClass('error-border')
    }
  });

  $.listen('parsley:field:success', function(e){
    if (e.$element.attr('id') == 'release_photo_id'){
      $('#cover').removeClass('error-border')
    }
  });
})(jQuery);
