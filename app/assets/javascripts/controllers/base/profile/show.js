(function($) {
  $(function(){
    function initialize() {
      var markerCenter = new google.maps.LatLng(gon.location.latitude, gon.location.longitude);

      var mapProp = {
        center:markerCenter,
        zoom:20,
        mapTypeId:google.maps.MapTypeId.TERRAIN
      };
      var map = new google.maps.Map(document.getElementById("googleMap"), mapProp);

      var marker = new google.maps.Marker({
        position:markerCenter
      });

      marker.setMap(map);
    }

    google.maps.event.addDomListener(window, 'load', initialize);
  });
})(jQuery);
