function reverse_geocode(){
    geocoder = new google.maps.Geocoder();
    get_variables = window.location.search.split('&');
    for(i=0;i<get_variables.length;i++){
        variable_name = get_variables[i].split('=')[0]
        variable_data = get_variables[i].split('=')[1]

        if(variable_name=='longitude')
            longitude = variable_data;
        if(variable_name=='latitude')
            latitude = variable_data;
        if(variable_name=='location')
            get_location = variable_data;
    }
    if(typeof(longitude)=='undefined')
        $('#s').attr('placeholder',get_location);
    else{
        var latlng = new google.maps.LatLng(latitude, longitude);
        geocoder.geocode({'latLng': latlng}, function(results, status) {
            result = results[0]['address_components'];
            for(i=0;i<result.length;i++){
                sub_result = result[i];
                if(sub_result['types'][0]=='sublocality'){
                    final_result = sub_result['long_name'];
                }
            }
            if (status == google.maps.GeocoderStatus.OK) {
                $('#s').attr('placeholder',final_result);
            }
        });
    }
}

