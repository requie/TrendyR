(function($) {
  $(function(){
    var location_attributes = /location\[/i;
    var $autocomplete_errors = $('#autocomplete').next();

    function initialize() {
      var autocomplete = new google.maps.places.Autocomplete((document.getElementById('autocomplete')), { types: ['geocode'] });
      google.maps.event.addListener(autocomplete, 'place_changed', function() {
        var place = autocomplete.getPlace();
        $('input[id^="location_"]').each(function() {
          $(this).val('');
        });
        $('#location_source').val(place.scope);
        $('#location_source_id').val(place.id);
        $('#location_source_place_id').val(place.place_id);
        $('#location_address').val(place.formatted_address);
        $('#location_types').val(place.types.join(','));
        $('#location_latitude').val(place.geometry.location.lat());
        $('#location_longitude').val(place.geometry.location.lng());
      });
    }

    initialize();
  });
})(jQuery);
