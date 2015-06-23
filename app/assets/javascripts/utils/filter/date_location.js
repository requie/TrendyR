(function($) {
  $(function() {
    var $form = $('#search-from'),
      $date = $('.datepicker'),
      $date_start = $date.first(),
      $date_finish = $date.last();

    $form.find('[name="utf8"]').remove();

    var autocompleteInput = document.getElementById('autocomplete'),
      autocomplete = new google.maps.places.Autocomplete(autocompleteInput, { types: ['(cities)'] });

    google.maps.event.addListener(autocomplete, 'place_changed', function() {
      var place = autocomplete.getPlace();

      if (place) {
        $form.find('#q_location_source_place_id_eq').val(place.place_id);
        $form.submit();
      }
    });

    $date.datepicker({
      dateFormat: 'yy-mm-dd'
    });

    var $q_start = $('#q_started_at_gteq'),
        $q_finish = $('#q_finished_at_lteq');

    if($q_start.val()) {
      $date_start.val($q_start.val().substring(0,10));
    }

    if($q_finish.val()) {
      $date_finish.val($q_finish.val().substring(0,10));
    }

    $date_start.on('change', function() {
      $q_start.val(this.value);
      $date_start.val(this.value);
      $form.submit();
    });

    $date_finish.on('change', function() {
      $q_finish.val(this.value);
      $date_finish.val(this.value);
      $form.submit();
    });
  });
})(jQuery);
