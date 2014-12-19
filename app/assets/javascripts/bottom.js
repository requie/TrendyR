/*
  Is included before closing </body> tag of the page
  Javascript files that are added to the page with <% javascript(...) %> helper (app/helpers/application_helper.rb)
  will appear after this file
 */

//= require jquery.min
//= require jquery-ui.min
//= require jquery.ui.touch-punch.min
//= require bootstrap.min
//= require tinynav.min
//= require scripts
//= require checkBo.min
//= require parsley

(function($) {
  $(function() {

    var $parsleyForm = $('.parsley-form');

    if ($parsleyForm.length) {
      $parsleyForm.parsley({
        namespace: 'data-',
        errorsWrapper: '<div class="error-message"></div>',
        errorTemplate: '<span></span>'
      });

      $.listen('parsley:form:validate', function() {
        var $error_div = $('.form-group .error-message').not('[id*="parsley"]');
        $error_div.closest('.form-group').find('input,select').removeClass('error-border');
        $error_div.remove();
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

  });
})(jQuery);