//app.factory('Geocoder', function($http){
//    return{
//        latitude: 0,
//        longitude: 0,
//        fetch_coordinates: function(){
//            return{
//                if (navigator.geolocation)
//                    navigator.geolocation.getCurrentPosition(showPosition,geo_error,{enableHighAccuracy: true, maximumAge: 0});
//            }
//        }
//    }
//}
//
//
//showPosition = function(position){
//    user_latitude = position.coords.latitude;
//    user_longitude = position.coords.longitude;
//    latitude = position.coords.latitude;
//    longitude = position.coords.longitude;
//    geocoder = new google.maps.Geocoder();
//    var latlng = new google.maps.LatLng(user_latitude, user_longitude);
//    geocoder.geocode({'latLng': latlng}, google_geocoding);
//}
//
//google_geocoding = function(results, status){
//    if(status=='ZERO_RESULTS')
//        html_element.attr('value','Search New Location ...');
//    else{
//        result = results[0]['address_components'];
//        for(i=0;i<result.length;i++){
//            sub_result = result[i];
//            if((sub_result['types'][0]=='sublocality')||(sub_result['types'][1]=='sublocality')||(sub_result['types'][2])=='sublocality'){
//                final_result = sub_result['long_name'];
//                $('#search-text').attr('value',final_result);
//            }
//        }
//        if (status == google.maps.GeocoderStatus.OK) {
//        }
//    }
//
//}
//
//geo_error = function(error){
//    new PNotify({
//        title: 'Location not identified',
//        text: 'Location services are disabled either for your browser or for your device. Please turn on location services and re-launch your browser.',
//    });
//}
