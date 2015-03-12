$(function(){

  var photo_ids = [];

  $('#upload').fileupload({
    url: Routes.photos_path(),
    dataType: 'json',
    options: {
      acceptFileTypes: /(\.|\/)(gif|jpe?g|png)$/i
    },
    formData:function (form) {
      return form.serializeArray();
    },
    add: function (e, data) {
      var tpl = $('.well.picture.m-b10.hidden').parent().clone();
      tpl.find('.picture').removeClass('hidden');

      data.context = tpl.insertAfter($('.form-group .col-xs-12:last-child'));

      var jqXHR = data.submit();
    },

    progress: function(e, data){
      var progress = parseInt(data.loaded / data.total * 100, 10);
      var lineBar = data.context.find('.lineBar');
      var countBar = data.context.find('.countBar');
      lineBar.data('value',progress).attr('data-value', progress);
      countBar.text(progress+"%");
      if(progress == 100){
        data.context.removeClass('working');
      }
    },

    done:function(e, data){
      var result = data.result.data;
      var $context = data.context;
      $context.find('.picture').replaceWith($('.editPicture.hidden').clone().removeClass("hidden"));
      $context.find('i').click(function(){
        $.ajax({
          url: Routes.photo_path(result.photo.id),
          type: 'DELETE'
        });
        $context.fadeOut(function(){
          $context.remove();
          photo_ids.splice( $.inArray(result.photo.id, photo_ids), 1 );
        });
      });
      $context.find('a').attr({ href : result.url }).addClass("gallery-image");
      $context.find('img').attr({ src : result.url });
      photo_ids.push(result.photo.id);
    },

    fail:function(e, data){
      data.context.addClass('error');
    }
  });

  var $form = $("form.simple_form")
    $form.submit( function(eventObj) {
    $('<input />').attr('type', 'hidden')
        .attr('name', "photo_ids")
        .attr('value', photo_ids)
        .appendTo($form);
    return true;
  });

});