var get_location  = '';
function reverse_geocode(html_element){
    get_variables = window.location.search.slice(1).split('&');
    for(i=0;i<get_variables.length;i++){
        variable_name = get_variables[i].split('=')[0]
        variable_data = get_variables[i].split('=')[1]

        if(variable_name=='longitude')
            user_longitude = variable_data;
        if(variable_name=='latitude')
            user_latitude = variable_data;
        if(variable_name=='location'){
            get_location = variable_data.replace('+',' ');
            get_location = get_location.toLowerCase();
            get_location = decodeURIComponent(get_location);
        }
    }
    if((typeof(user_longitude)=='undefined')||user_longitude ==0)
        html_element.attr('value',get_location);
    else{
        google_api_call(html_element, user_latitude,user_longitude);
    }
}

function google_api_call(html_element, user_latitude,user_longitude){

    geocoder = new google.maps.Geocoder();
        var latlng = new google.maps.LatLng(user_latitude, user_longitude);
        geocoder.geocode({'latLng': latlng}, function(results, status) {
            if(status=='ZERO_RESULTS')
                html_element.attr('value','Search New Location ...');
            else{
            result = results[0]['address_components'];
            for(i=0;i<result.length;i++){
                sub_result = result[i];
                if(sub_result['types'][0]=='sublocality'){
                    final_result = sub_result['long_name'];
                }
            }
            if (status == google.maps.GeocoderStatus.OK) {
                html_element.attr('value',final_result);
            }
            }
        });
}
