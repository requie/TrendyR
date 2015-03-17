$(function(){

  var photo_ids = [];
  var $number_of_photos = $('input#number-of-photos');
  var number_of_photos = 0;

  function make_photo_deletable(context, photo_id){
    context.find('i').click(function(){
      $.ajax({
        url: Routes.photo_path(photo_id),
        type: 'DELETE'
      });
      context.fadeOut(function(){
        context.remove();
        photo_ids.splice( $.inArray(photo_id, photo_ids), 1 );
        number_of_photos--;
        $number_of_photos.attr('value',number_of_photos);
      });
    });
  }

  $(document).ready(function (){
    if(!$.isEmptyObject(gon.photos)) {
      var $picture = $('<div>').addClass('col-xs-12 col-sm-6 col-md-3').append($('.editPicture.hidden').clone());
      $picture.find('.editPicture').removeClass('hidden');
        gon.photos.forEach(function (photo) {
          $image = $picture.clone().insertAfter($('.form-group .col-xs-12:last-child'));
          $image.find('a').attr({href: photo.url}).addClass("gallery-image");
          $image.find('img').attr({src: photo.url});
          make_photo_deletable($image, photo.id);
        });
      number_of_photos = gon.photos.length;
      $number_of_photos.attr('value',number_of_photos);
    }
  });

  var $form = $("form.simple_form");


  $form.submit( function(eventObj) {
    $('<input />').attr('type', 'hidden')
        .attr('name', "photo_ids")
        .attr('value', photo_ids)
        .appendTo($form);
    return true;
  });
  $('#upload').fileupload({
    url: Routes.photos_path(),
    dataType: 'json',
    //acceptFileTypes: /(\.|\/)(jpe?g|png)$/i,
    //maxFileSize: 10000000
  }).bind('fileuploadstop', function (e, data) {

  }).bind('fileuploadsend', function (e, data) {
    var tpl = $('.well.picture.m-b10.hidden').parent().clone();
    tpl.find('.picture').removeClass('hidden');
    data.context = tpl.insertAfter($('.form-group .col-xs-12:last-child'));
  }).bind('fileuploadprogress',function(e, data){
    var progress = parseInt(data.loaded / data.total * 100, 10);
    var lineBar = data.context.find('.lineBar');
    var countBar = data.context.find('.countBar');
    lineBar.data('value',progress).attr('data-value', progress);
    countBar.text(progress+"%");
  }).bind('fileuploaddone',function(e, data){
    var result = data.result.data;
    var $context = data.context;
    $context.find('.picture').replaceWith($('.editPicture.hidden').clone().removeClass("hidden"));
    make_photo_deletable($context,result.photo.id);
    $context.find('a').attr({ href : result.url }).addClass("gallery-image");
    $context.find('img').attr({ src : result.url });
    photo_ids.push(result.photo.id);
    number_of_photos++;
    $number_of_photos.attr('value',number_of_photos);
  }).bind('fileuploadprocessfail',function(e, data){
    console.log(data.files[0].error);
  });

  var $er = $number_of_photos.siblings('.error-message');
  $('.form-group.row').addClass('has-error');
  $('<div>').addClass('col-xs-12').append($er).prependTo('.form-group.row.has-error');

  $.listen('parsley:field:validate', function(smth){
    $('#photos-uploading').val(jQuery.active);
  });

  window.ParsleyValidator
      .addValidator('allconnectionsclosed', function (value, requirement) {
        return 0 === jQuery.active;
      }, 32);

  $form.parsley();
});