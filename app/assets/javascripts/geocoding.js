function map_initializer(locations, user_location){
    var marker, i;
    var user_position = new google.maps.LatLng(user_location[0], user_location[1]);
    var ascii_letter = 64;
    var map = new google.maps.Map(document.getElementById('map'), {
        zoom: 12,
        center: new google.maps.LatLng(locations[0][0], locations[0][1]),
        mapTypeControl: false,
        zoomControl: false,
        mapTypeId: google.maps.MapTypeId.ROADMAP
    });

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
        google.maps.event.addListener(marker, 'click', function(marker){
            coords = marker["latLng"]["d"].toFixed(5).toString()+marker["latLng"]["e"].toFixed(5).toString();
            element = document.getElementById(coords);
            $('body').scrollTo(element,{duration: 'slow'});
        });
    }

    var populationOptions = {
        strokeColor: '#FF0000',
        strokeOpacity: 0.8,
        strokeWeight: 2,
        fillColor: '#FF0000',
        fillOpacity: 0.35,
        map: map,
        center: user_position,
        radius: 5000
    };
    // Add the circle for this city to the map.
    cityCircle = new google.maps.Circle(populationOptions);
}

var latitude;
var longitude;
function change_location(){
    q=(document.location.href);
    domain = document.location.origin;
    route  = document.location.pathname;
    user_geolocate();

    var new_link=document.getElementById("change_location");
    console.log(longitude);
    if(longitude == undefined){
        console.log("not defined");
        $.pnotify({
            title: 'Enable location service',
            text: "enable",
            closer_hover: false,
            opacity: .9
        });
    }
    else
        {
            console.log("defined");
            new_link.href = domain+route+'?longitude='+longitude+'&latitude='+latitude,'_self','resizable,location,menubar,toolbar,scrollbars,status';
            console.log(new_link.href);
        }
}

function user_geolocate(){
    if (navigator.geolocation)
        navigator.geolocation.getCurrentPosition(showPosition,geo_error);
}

function showPosition(position){
    latitude = position.coords.latitude;
    longitude = position.coords.longitude;
}

function geo_error(){
    console.log("couldn't fetch co-ordinates");
}
