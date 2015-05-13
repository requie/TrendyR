(function($) {
  $(function(){

    function initialize() {
      var autocompleteInput = document.getElementById('autocomplete'),
        autocomplete = new google.maps.places.Autocomplete(autocompleteInput, { types: ['(cities)'] });

      function clearLocationFields() {
        $('input[id^="location_"]').val('');
      }

      google.maps.event.addListener(autocomplete, 'place_changed', function() {
        var place = autocomplete.getPlace();
        clearLocationFields();

        $('#location_source').val(place.scope);
        $('#location_source_id').val(place.id);
        $('#location_source_place_id').val(place.place_id);
        $('#location_address').val(place.formatted_address);
        $('#location_types').val(place.types.join(','));
        $('#location_latitude').val(place.geometry.location.lat());
        $('#location_longitude').val(place.geometry.location.lng());
      });

      $(autocompleteInput).keyup(function() {
        if (!this.value) {
          clearLocationFields();
        }
      });
    }

    initialize();
  });
})(jQuery);
