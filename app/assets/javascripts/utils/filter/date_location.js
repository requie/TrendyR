(function($) {
  $(function() {
    var $form = $('#search-from'),
      $date = $('.datepicker');

    $form.find('[name="utf8"]').remove();

    $form.on('submit', function(e) {
      e.preventDefault();
    });

    var autocompleteInput = document.getElementById('autocomplete'),
      autocomplete = new google.maps.places.Autocomplete(autocompleteInput, { types: ['(cities)'] });

    google.maps.event.addListener(autocomplete, 'place_changed', function() {
      var place = autocomplete.getPlace();

      if (place) {
        $form.find('#q_profile_location_source_place_id_eq').val(place.place_id);
        $form.submit();
      }
    });

    $date.datepicker({
      dateFormat: 'dd/mm/yy'
    });

    $date.on('change', function() {
      $date.val(this.value);
      $form.submit();
    });
  });
})(jQuery);
