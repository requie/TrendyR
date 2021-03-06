//= require jquery_fileupload/jquery.fileupload
//= require jquery_fileupload/jquery.fileupload-process
//= require jquery_fileupload/jquery.fileupload-validate
//= require jquery_fileupload/jquery.iframe-transport
//= require jquery_fileupload/jquery.ui.widget
//= require jquery/jquery.Jcrop.min
//= require utils/jcrop_setup

(function($) {
  $(function(){

    var fileupload_options = {
      url: Routes.photos_path(),
      dataType: ' json',
      singleFileUploads: true,
      multipart: true,
      autoUpload: true,
      acceptFileTypes: /(\.|\/)(jpe?g|png)$/i,
      maxNumberOfFiles: 1
    };

    $('.uploadbtn').fileupload(fileupload_options).bind('fileuploaddone', function (e, data) {
      var photo = data.result.photo;

      window.utils.crop.init({
        photo_id: photo.id,
        preset: 'avatar',
        $cropForm: $('#crop-container'),
        done: function(response, status, jqXHR){
          var photo_url = response.photo.url;
          $('.managerAvatar img').attr('src', photo_url);
          $.ajax({
            url: Routes.update_photo_private_profile_path(),
            type: 'PATCH',
            data: {
              profile: {
                photo_id: response.photo.id
              }
            }
          });
        },
        fail: function(response, status, jqXHR){}
      });

      window.utils.crop.show({
        photo_url: photo.url,
        trueSize: [photo.width, photo.height],
        boxWidth: 640,
        boxHeight: 480,
        aspectRatio: 1
      });
    });

    $('.uploadfile').fileupload(fileupload_options).bind('fileuploaddone', function (e, data) {
      var photo = data.result.photo;

      window.utils.crop.init({
        photo_id: photo.id,
        $cropForm: $('#crop-container'),
        preset: 'wallpaper',
        done: function(response, status, jqXHR){
          var photo_url = response.photo.url;
          $wallpaper.backstretch(photo_url);
          $.ajax({
            url: Routes.update_photo_private_profile_path(),
            type: 'PATCH',
            data: {
              profile: {
                wallpaper_id: response.photo.id
              }
            }
          });
        },
        fail: function(response, status, jqXHR){}
      });

      window.utils.crop.show({
        photo_url: photo.url,
        trueSize: [photo.width, photo.height],
        boxWidth: 640,
        boxHeight: 480,
        aspectRatio: 2.5
      });
    });

    var $wallpaper = $('.manadgmentFoto');
    $wallpaper.backstretch($wallpaper.find('[name=background-image]').val());
  });
})(jQuery);
