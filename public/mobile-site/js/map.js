function initialize() {
  var myOptions = {
    zoom: 4,
    center: new google.maps.LatLng(-33, 151),
    disableDefaultUI: true,
    mapTypeId: google.maps.MapTypeId.ROADMAP  
  }
  var map = new google.maps.Map(document.getElementById("map_canvas"),
       myOptions);
}