(function($) {
  $(function(){

    function initialize() {
      var autocomplete_input = document.getElementById('autocomplete')
      var autocomplete = new google.maps.places.Autocomplete(autocomplete_input, { types: ['geocode'] });

      function clearLocationFields(){
        $('input[id^="location_"]').each(function() {
          $(this).val('');
        });
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

      $(autocomplete_input).keyup(function() {
        if (!this.value) {
          clearLocationFields();
        }
      });
    }

    initialize();
  });
})(jQuery);
