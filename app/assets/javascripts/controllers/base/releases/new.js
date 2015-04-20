(function($) {
  $(function () {
    var $songUpload = $('#song-upload');
    var $cover = $('#cover');

    $songUpload.fileupload({
      url: Routes.songs_path(),
      acceptFileTypes: /(\.|\/)(mp3|wav)$/i,
      maxFileSize: 10000000
    }).bind('fileuploadsend', function (e, data) {

    }).bind('fileuploadprogress', function(e, data){
      var progress = parseInt(data.loaded / data.total * 100, 10);
    }).bind('fileuploaddone', function(e, data){

    }).bind('fileuploadprocessfail', function(e, data){
      console.log(data.files[0].error);
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
    }).bind('fileuploadprocessfail', function(e, data){
      console.log(data.files[0].error);
    });
  });
})(jQuery);
