(function () {
  window.ParsleyConfig = {

    validators: {
      cardNumber: {
        fn: function (value) {
          return Stripe.card.validateCardNumber(value);
        }
      },
      cvc: {
        fn: function (value) {
          return Stripe.card.validateCVC(value);
        }
      }
    }
  }
})();
