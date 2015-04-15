(function($) {
  $(function () {

    var autocomplete_input = document.getElementById('autocomplete');
    var autocomplete = new google.maps.places.Autocomplete(autocomplete_input, { types: ['geocode'] });

    google.maps.event.addListener(autocomplete, 'place_changed', function() {
      var place = autocomplete.getPlace();
      var params = 'source_id=' + place.id;
      if ($.urlParam('date')) {
        params += '&date=' + $.urlParam('date');
      }
      window.location.search = params;
    });

    $('.inputDate').datepicker({
      dateFormat: 'dd/mm/yy',
      onSelect: function(inputText) {
        var params = 'date=' + inputText;
        if ($.urlParam('source_id')) {
          params += '&source_id=' + $.urlParam('source_id');
        }
        window.location.search = params;
      }
    });

    if($.urlParam('date')){
      $('.inputDate').datepicker('setDate', $.urlParam('date'));
    }
  });
})(jQuery);