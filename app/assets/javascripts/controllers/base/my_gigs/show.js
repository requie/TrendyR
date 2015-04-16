(function($) {
  $(function () {

    var autocomplete_input = document.getElementById('autocomplete');
    var autocomplete = new google.maps.places.Autocomplete(autocomplete_input, { types: ['geocode'] });
    var $form = $('#filters');
    var $place_id = $form.find('#filters_source_place_id');
    var $address = $form.find('#filters_address');

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

    $('.inputDate').datepicker({
      dateFormat: 'dd/mm/yy',
      onSelect: function(inputText) {
        $form.submit();
      }
    });

    if($.urlParam('filters%5Bsource_place_id%5D')) {
      $place_id.val($.urlParam('filters%5Bsource_place_id%5D'));
      $address.val(decodeURIComponent($.urlParam('filters%5Baddress%5D')).replace(/\+/g, " "));
      $(autocomplete_input).val($address.val());
    }

    if($.urlParam('filters%5Bdate%5D')){
      $('.inputDate').datepicker('setDate', decodeURIComponent($.urlParam('filters%5Bdate%5D')));
    }
  });
})(jQuery);