/*
  Is included before closing </body> tag of the page
  Javascript files that are added to the page with <% javascript(...) %> helper (app/helpers/application_helper.rb)
  will appear after this file
 */

//= require jquery.min
//= require jquery-ui.min
//= require jquery.ui.touch-punch.min
//= require jquery.fancybox.pack
//= require jquery.jtruncate
//= require jquery.Jcrop.min
//= require jquery.backstretch.min
//= require bootstrap.min
//= require tinynav.min
//= require slick
//= require function
//= require scripts
//= require checkBo.min
//= require parsley_setup
//= require parsley
//= require audio
//= require player
//= require video
//= require jquery-file-upload/vendor/jquery.ui.widget
//= require jquery-file-upload/jquery.iframe-transport
//= require jquery-file-upload/jquery.fileupload
//= require jquery-file-upload/jquery.fileupload-process
//= require jquery-file-upload/jquery.fileupload-validate
//= require jquery_ujs
//= require underscore
//= require jcrop_setup
//= require tinymce
//= require jquery-te-1.4.0.min
//= require jquery.maskMoney.min
//= require url_parameters

window.utils = {};

(function($) {
  $(function() {

    var $parsleyForm = $('.parsley-form');

    if ($parsleyForm.length) {
      $parsleyForm.parsley();

      $.listen('parsley:field:success', function(e) {
        e.$element.closest('.form-group').find('input, select, .mce-tinymce, textarea').removeClass('error-border');
      });

      $.listen('parsley:field:error', function(e) {
        e.$element.closest('.form-group').find('input, select, .mce-tinymce, textarea').addClass('error-border');
      });

    }

    // fit the height of the document
    var fitHeight = function () {
      $('.fit-height').css('height', window.innerHeight);
    };

    fitHeight();

    $(window).resize(function () {
      fitHeight();
    });

    $('.logFacebook, .logTwitter, .logGoogle').on('click', function(e) {
      e.preventDefault();
      var url = $(this).attr('data-url');
      window.location.href = url;
    });

    $('.alert-message').delay(3000).fadeOut(500, function() {
      $(this).remove();
    });

  });
})(jQuery);
