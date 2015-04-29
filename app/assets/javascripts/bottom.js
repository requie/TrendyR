/*
  Is included before closing </body> tag of the page
  Javascript files that are added to the page with <% javascript(...) %> helper (app/helpers/application_helper.rb)
  will appear after this file
 */

//= require modernizr.custom
//= require jquery
//= require bootstrap.min
//= require jquery/jquery-ui.min
//= require jquery/jquery.ui.touch-punch.min
//= require jquery/jquery-te-1.4.0.min
//= require jquery/jquery.backstretch.min
//= require jquery/jquery.fancybox.pack
//= require jquery/jquery.jtruncate
//= require jquery/jquery.maskMoney.min
//= require checkBo
//= require slick
//= require tinynav.min
//= require underscore
//= require custom/function
//= require custom/main
//= require custom/scripts

window.utils = {};

(function($) {
  $(function() {
    // CSRF token
    $.ajaxSetup({
      headers: {
        'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
      }
    });

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
