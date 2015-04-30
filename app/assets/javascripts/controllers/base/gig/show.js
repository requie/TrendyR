//= require utils/url_parameters

(function($) {
  $(function () {

    var autocomplete_input = document.getElementById('autocomplete');
    var autocomplete = new google.maps.places.Autocomplete(autocomplete_input, { types: ['geocode'] });
    var $form = $('#filters');
    var $place_id = $form.find('#q_location_source_place_id_eq');
    var $address = $form.find('#q_location_address_eq');
    var $date = $('.inputDate');
    var $finish_gt = $('#q_finished_at_gteq');

    google.maps.event.addListener(autocomplete, 'place_changed', function() {
      var place = autocomplete.getPlace();
      $place_id.val(place.place_id);
      $address.val(place.formatted_address);
      $form.submit();
    });

    $(autocomplete_input).keyup(function() {
      if (!this.value) {
        $place_id.val('');
        $address.val('');
      }
    });

    $date.datepicker({
      dateFormat: 'dd/mm/yy'
    });

    $date.on('change', function() {
      $finish_gt.val(this.value);
      $form.submit();
    });

    if($.urlParam('q\\[location_source_place_id_eq\\]')) {
      $place_id.val($.urlParam('q\\[location_source_place_id_eq\\]'));
      $address.val($.urlParam('q\\[location_address_eq\\]').replace(/\+/g, " "));
      $(autocomplete_input).val($address.val());
    }

    if($.urlParam('q\\[started_at_lteq\\]')){
      $date.datepicker('setDate', $.urlParam('q\\[started_at_lteq\\]'));
    }
  });
})(jQuery);
