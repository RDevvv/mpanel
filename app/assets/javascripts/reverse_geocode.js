function reverse_geocode(){
    geocoder = new google.maps.Geocoder();
    get_variables = window.location.search.slice(1).split('&');
    for(i=0;i<get_variables.length;i++){
        variable_name = get_variables[i].split('=')[0]
        variable_data = get_variables[i].split('=')[1]

        if(variable_name=='longitude')
            user_longitude = variable_data;
        if(variable_name=='latitude')
            user_latitude = variable_data;
        if(variable_name=='location')
            get_location = variable_data;
    }
    if(typeof(user_longitude)=='undefined'||user_longitude ==0)
        $('#s').attr('value',get_location.replace('+',' '));
    else{
        var latlng = new google.maps.LatLng(latitude, user_longitude);
        geocoder.geocode({'latLng': latlng}, function(results, status) {
            result = results[0]['address_components'];
            for(i=0;i<result.length;i++){
                sub_result = result[i];
                if(sub_result['types'][0]=='sublocality'){
                    final_result = sub_result['long_name'];
                }
            }
            if (status == google.maps.GeocoderStatus.OK) {
                $('#s').attr('value',final_result);
            }
        });
    }
}

