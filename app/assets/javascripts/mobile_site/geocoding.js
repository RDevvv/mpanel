function map_initializer(locations, user_location){
    var marker, i;
    var user_position = new google.maps.LatLng(user_location[0], user_location[1]);
    var ascii_letter = 64;
    var map = new google.maps.Map(document.getElementById('map'), {
        zoom: 13,
        center: new google.maps.LatLng(locations[0][0], locations[0][1]),
        mapTypeControl: false,
        zoomControl: false,
        mapTypeId: google.maps.MapTypeId.ROADMAP
    });
    oms = new OverlappingMarkerSpiderfier(map,{keepSpiderfied: true});
    user= new google.maps.Marker({
        position: user_position,
        icon: "http://www.gullakmaster.com/assets/user_pin.png",
        map: map
    });


    for (i = 0; i < locations.length; i++) {
        ascii_letter += 1;
        letter = String.fromCharCode(ascii_letter);
        marker = new google.maps.Marker({
            position: new google.maps.LatLng(locations[i][0], locations[i][1]),
            icon: "http://maps.google.com/mapfiles/marker" + letter + ".png",
            map: map
        });
        marker.metadata ={id: locations[i][2]};
        oms.addMarker(marker);
    }

    oms.addListener('click', function(marker,event){
        coords = marker["metadata"]["id"];
        element = document.getElementById(coords);
        $('body').scrollTo(element,{duration: 'slow'});
    });

    var populationOptions = {
        strokeColor: '#008080',
        strokeOpacity: 0.8,
        strokeWeight: 2,
        fillColor: '#5F9F9F',
        fillOpacity: 0.15,
        map: map,
        center: user_position,
        radius: 3000
    };
    // Add the circle for this city to the map.
    cityCircle = new google.maps.Circle(populationOptions);
}

var user_latitude=0;
var user_longitude=0;
function change_location(){
    q=(document.location.href);
    domain = document.location.origin;
    route  = document.location.pathname;
    if (navigator.geolocation)
        navigator.geolocation.getCurrentPosition(showPosition,geo_error,{enableHighAccuracy: true, maximumAge: 0});
}

function showPosition(position){
    var new_link=document.getElementById("change_location");
    user_latitude = position.coords.latitude;
    user_longitude = position.coords.longitude;

    get_variables = window.location.search.slice(1).split('&');
    for(i=0;i<get_variables.length;i++){
        variable_name = get_variables[i].split('=')[0]
        variable_data = get_variables[i].split('=')[1]

        if(variable_name=='view')
            view = variable_data;
    }
    new_link.href = domain+route+'?longitude='+user_longitude+'&latitude='+user_latitude+'&view='+view,'_self','resizable,location,menubar,toolbar,scrollbars,status';
}

function geo_error(error){
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
