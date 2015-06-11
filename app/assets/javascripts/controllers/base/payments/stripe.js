(function($) {
  $(function() {
    if (!Stripe) {
      console.error('stripe.js library not found!');
      return;
    }

    var notificationWindow = window.utils.notification;

    Stripe.setPublishableKey(gon.stripe_publishable_key);

    var $form = $('#stripe-info-form'),
      $paymentForm = $('#stripe-token-form'),
      $submitButton = $form.find('button[type="submit"]'),
      $quantityInput = $('#quantity'),
      $priceLabel = $('#price'),
      price = gon.price;

    $form.parsley({
      namespace: 'data-',
      errorsWrapper: ''
    });

    $form.on('submit', function(e) {
      e.preventDefault();
      $submitButton.attr('disabled', true);
      Stripe.card.createToken($form, function(status, response) {
        if (response.error) {
          notificationWindow.show({
            text: response.error.message,
            class: 'validate-red'
          });
          $submitButton.removeAttr('disabled');
        } else {
          $form.attr('disabled', true);
          $paymentForm.find('[name="stripe_token"]').val(response.id);
          $paymentForm.find('[name="ticket_count"]').val($quantityInput.val());
          $paymentForm.submit();
        }
      });

      return false;
    });

    $quantityInput.on('change', function() {
      var priceValue = (this.value * gon.price).toFixed(2);
      $priceLabel.html(priceValue);
    });
  });
})(jQuery);
