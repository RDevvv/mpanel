app.controller('GeocodingController',function($scope){

    var user_latitude=0;
    var user_longitude=0;
    $scope.searchh = '';
    $scope.latitude = 0;
    $scope.longitude = 0;
    $scope.change_location = function(){
        if (navigator.geolocation)
            navigator.geolocation.getCurrentPosition($scope.showPosition,$scope.geo_error,{enableHighAccuracy: true, maximumAge: 0});
    }

    $scope.showPosition = function(position){
        var new_link=document.getElementById("change_location");
        user_latitude = position.coords.latitude;
        user_longitude = position.coords.longitude;
        $scope.latitude = position.coords.latitude;
        $scope.longitude = position.coords.longitude;
        $scope.$apply();
        geocoder = new google.maps.Geocoder();
        var latlng = new google.maps.LatLng(user_latitude, user_longitude);
        geocoder.geocode({'latLng': latlng}, $scope.google_geocoding);
    }

    $scope.google_geocoding = function(results, status){
        if(status=='ZERO_RESULTS')
            html_element.attr('value','Search New Location ...');
        else{
            result = results[0]['address_components'];
            for(i=0;i<result.length;i++){
                sub_result = result[i];
                if(sub_result['types'][0]=='sublocality'){
                    final_result = sub_result['long_name'];
                    $('#search-text').attr('value',final_result);
                    $scope.searchh = final_result;
                    $scope.$apply();
                }
            }
            if (status == google.maps.GeocoderStatus.OK) {
            }
        }

    }

    $scope.geo_error = function(error){
        $.pnotify({
            title: 'Location not identified',
            text: 'Location services are disabled either for your browser or for your device. Please turn on location services and re-launch your browser.',
            sticker_hover: false,
            animate_speed: 'fast',
            icon: false,
            closer_hover: false,
            opacity: .9
        });
    }
})
