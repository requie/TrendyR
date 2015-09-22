//= require utils/parsley_setup
//= require parsley
//= require utils/parsley-init

(function($) {
  $(function () {

    $('#booking_total_fee').maskMoney({
      thousands: '',
      decimal: '.',
      allowZero: true,
      suffix: ' $'
    });

  });
})(jQuery);
