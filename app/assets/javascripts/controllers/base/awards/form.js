(function($) {
  $(function() {
    new window.utils.photoUpload($('.uploadbtn'), {
      crop: {
        preset: 'avatar',
        done: function(response){
          $('#photo-id').val(response.photo.id);
          $('.image-error').removeClass('.error-border');
        },
        fail: function(){
          console.log('crop error');
        }
      }
    });
  });
})(jQuery);
