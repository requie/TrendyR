(function($) {
  $(function() {
    var $displayBlock = $('[data-display-block]'),
      $imageContainer = $displayBlock.find('img'),
      $removeButton = $displayBlock.find('[data-remove-img]'),
      $photoId = $('#photo-id'),
      $errorBorder = $('.image-error');

    $removeButton.on('click', function(e) {
      e.preventDefault();
      $photoId.val('');
      $imageContainer.attr('src', '');
    });

    new window.utils.photoUpload($('.uploadbtn'), {
      crop: {
        preset: 'avatar',
        done: function(response){
          $imageContainer.attr('src', response.photo.url);
          $photoId.val(response.photo.id);
          $errorBorder.removeClass('.error-border');
        },
        fail: function(){
          console.log('crop error');
        }
      }
    });
  });
})(jQuery);
