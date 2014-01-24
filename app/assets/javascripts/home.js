function map_initializer(locations, user_location){
    var marker, i;
    var user_position = new google.maps.LatLng(user_location[0], user_location[1]);
    var ascii_letter = 64;
    var map = new google.maps.Map(document.getElementById('map'), {
        zoom: 12,
        center: new google.maps.LatLng(locations[0][0], locations[0][1]),
        mapTypeId: google.maps.MapTypeId.ROADMAP
    });

        user= new google.maps.Marker({
            position: user_position,
            icon: "http://0.0.0.0:3000/assets/user_pin.png",
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
        google.maps.event.addListener(marker, 'click', move_ad_to_top);
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

function move_ad_to_top(){
    console.log("vivek");
}

function check_if_mobile_number_exists(){
    if($.cookie("mobile_number") == 'false')
        $('.modal').modal('show');
}

function modal_submit(){
    $('.customer-mobile-number-form').submit(function() {
        var valuesToSubmit = $(this).serialize();
        $.ajax({
            url: "/get_mobile_number/1", //'/notifications/4',sumbits it to the given url of the form
            dataType: 'text',
            data: valuesToSubmit,
            method: 'POST'
        }).success(function(json){
            $('.modal').modal('hide');
            $.pnotify({ title: '', text: 'Thank you for subscribing', closer_hover: false, opacity: .9 });
        });
        return false; // prevents normal behaviour
    });
}


function track(element) {
    customer_uuid = $.cookie("customer_uuid");
    button_class  = $(element).attr("class").split(" ")[0];
    box_element   = $(element).closest('div[class="bdiv"]');
    redirection_url = "get_button_click.json";
    ad_id         = box_element.attr("id");
    outlet_id     = box_element.attr("outlet_id");
    current_link  = window.location.pathname;

    if(button_class=='call')
        check_if_mobile_number_exists();

    $.ajax({
        url: redirection_url,
        type: "post",
        data: {
            'customer_uuid': customer_uuid,
            'ad_id': ad_id,
            'outlet_id': outlet_id,
            'button_class': button_class,
            'current_link': current_link
        }
    }).done(function () {
        console.log("done");
    })
}

function send_ad(customer_uuid, element)
{
    customer_uuid = $.cookie("customer_uuid");
    ad_id         = $(element).closest('div[class="bdiv"]').attr("id");
    outlet_id     = $(element).closest('div[class="bdiv"]').attr("outlet_id");

    $.ajax({
        url: "set_sms_data.json",
        type: "post",
        dataType: "json",
        data: {
            'customer_uuid': customer_uuid,
            'ad_id': ad_id,
            'outlet_id': outlet_id
        }
    }).success(function (data) {
        //string = JSON.parse(data);
        if(data["mobile_number_presence"] == false)
            $('.modal').modal('show');
        else
            $.pnotify({
                title: 'ad sent',
                text: data["text"],
                closer_hover: false,
                opacity: .9
            });

    })
}

var latitude;
var longitude;
function change_location(){
    q=(document.location.href);
    domain = document.location.origin;
    route  = document.location.pathname;
    user_geolocate();

    var new_link=document.getElementById("change_location");
    //domain+route+'?longitude='+longitude+'&latitude='+latitude,'_self','resizable,location,menubar,toolbar,scrollbars,status');
}

function user_geolocate(){
    if (navigator.geolocation)
    navigator.geolocation.getCurrentPosition(showPosition,geo_error);
}

function showPosition(position){
    latitude = position.coords.latitude;
    longitude = position.coords.longitude;
    get_variables = new_link.href.split("?")[1];
    //lat_long =
}

function geo_error(){
    console.log("couldn't fetch co-ordinates");
}

function get_backtotop_button(){

            var pxShow = 80;//height on which the button will show
            var fadeInTime = 500;//how slow/fast you want the button to show
            var fadeOutTime = 500;//how slow/fast you want the button to hide
            var scrollSpeed = 500;//how slow/fast you want the button to scroll to top. can be a value, 'slow', 'normal' or 'fast'
            jQuery(window).scroll(function(){
                if(jQuery(window).scrollTop() >= pxShow){
                    jQuery("#backtotop").fadeIn(fadeInTime);
                }else{
                    jQuery("#backtotop").fadeOut(fadeOutTime);
                }
            });
            jQuery('#backtotop a').click(function(){
                jQuery('html, body').animate({scrollTop:0}, scrollSpeed);
                return false;
            });


}
