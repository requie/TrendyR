$(function(){

  var fileupload_options = {
    url: Routes.photos_path(),
        dataType:' json',
      singleFileUploads: true,
      multipart: true,
      autoUpload: true,
      processQueue: [{
    action: 'validate',
    always: true,
    acceptFileTypes: /(\.|\/)(jpe?g|png)$/i,
    maxFileSize: 1024 * 1024 * 10, // 10 mb
    maxNumberOfFiles: 1
  }]
  };

  $('.uploadbtn').fileupload(fileupload_options).bind('fileuploaddone', function (e, data) {
    var result = data.result.data;

    window.utils.crop.init({
      photo_id: result.photo.id,
      $cropForm: $('#crop-container'),
      done: function(response, status, jqXHR){
        window.utils.crop.hide();
        var photo_url = response.data.url;
        $('.managerAvatar img').attr('src',photo_url);
        $.ajax({
          url: Routes.base_profile_update_photo_path(response.data.profile_id),
          type: 'PATCH',
          data: { photo_id: response.data.photo.id }
        });
      },
      fail: function(response, status, jqXHR){}
    });

    window.utils.crop.show({
      photo_url: result.url,
      trueSize: [result.photo_width,result.photo_height],
      aspectRatio: 1
    });
  }).bind('fileuploadprocessfail',function(e, data){
    console.log(data.files[0].error);
  });


  fileupload_options.processQueue[0].maxFileSize = 1024*1024*20

  $('.uploadfile').fileupload(fileupload_options).bind('fileuploaddone', function (e, data) {
    var result = data.result.data;

    window.utils.crop.init({
      photo_id: result.photo.id,
      $cropForm: $('#crop-container'),
      done: function(response, status, jqXHR){
        window.utils.crop.hide();
        var photo_url = response.data.url;
        $('.manadgmentFoto').attr('style',"background-image:url("+photo_url+"); ");
        $.ajax({
          url: Routes.base_profile_update_wallpaper_path(response.data.profile_id),
          type: 'PATCH',
          data: { photo_id: response.data.photo.id }
        });
      },
      fail: function(response, status, jqXHR){}
    });

    window.utils.crop.show({
      photo_url: result.url,
      trueSize: [result.photo_width,result.photo_height],
      aspectRatio: 2.5
    });
  }).bind('fileuploadprocessfail',function(e, data){
    console.log(data.files[0].error);
  });
});

