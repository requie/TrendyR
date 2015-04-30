//= require parsley
//= require utils/parsley_setup
//= require utils/parsley-init
//= require jquery_fileupload/jquery.fileupload
//= require jquery_fileupload/jquery.fileupload-process
//= require jquery_fileupload/jquery.fileupload-validate
//= require jquery_fileupload/jquery.iframe-transport
//= require jquery_fileupload/jquery.ui.widget

(function($) {
  $(function(){

    var $number_of_photos = $('input#number-of-photos');

    var $form = $("form.simple_form");

    $form.on('click', 'i.icon-removePicture', function(e){
      var $parent_div = $(this).parents().get(1);
      $($parent_div).fadeOut(function(){
        $parent_div.remove();
      });
    });

    $('#upload').fileupload({
      url: Routes.photos_path(),
      dataType: 'json',
      acceptFileTypes: /(\.|\/)(jpe?g|png)$/i,
      maxFileSize: 10000000
    }).bind('fileuploadsend', function (e, data) {
      var tpl = $('.well.picture.m-b10.hidden').parent().clone();
      tpl.find('.picture').removeClass('hidden');
      data.context = tpl.insertAfter($('.form-group .col-xs-12:last'));
    }).bind('fileuploadprogress', function(e, data){
      var progress = parseInt(data.loaded / data.total * 100, 10);
      var lineBar = data.context.find('.lineBar');
      var countBar = data.context.find('.countBar');
      lineBar.data('value', progress).attr('data-value', progress);
      countBar.text(progress + "%");
    }).bind('fileuploaddone', function(e, data){
      var photo = data.result.photo;
      var $context = data.context;
      $context.find('.picture').replaceWith($('.editPicture.hidden').clone().removeClass("hidden"));
      $context.find('a').attr({ href : photo.url }).addClass("gallery-image");
      $context.find('img').attr({ src : photo.url });
      $context.find('input').attr({ value: photo.id }).addClass('photo_id');
    }).bind('fileuploadprocessfail', function(e, data){
      console.log(data.files[0].error);
    });

    var $er = $number_of_photos.siblings('.error-message');
    $('.form-group.row').addClass('has-error');
    $('<div>').addClass('col-xs-12').append($er).prependTo('.form-group.row.has-error');
  });
})(jQuery);
