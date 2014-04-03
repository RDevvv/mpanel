function display_ad(element){
    closest_search_pattern = 'div[class="pin-add-div"]';
    customer_uuid = $.cookie("customer_uuid");
    ad_id         = $(element).closest(closest_search_pattern).attr("ad_id");
    outlet_id     = $(element).closest(closest_search_pattern).attr("outlet_id");
    title         = "Ad sent";
    $.ajax({
        url: '/ad_details/'+ad_id+'.json'
    }).success(function show_ad(data){
        $.pnotify({ title: data['brand_name']+" - "+data['title'], text: data['sms_text'],
        closer_hover: false,
        sticker_hover: false,
        animate_speed: 'fast',
        icon: false,
        addclass: 'stack-topleft',
        opacity: .9
    });
    }
    )
}
function bind_display_ad(){
    $('.button_view').click(function(){
        display_ad($(this))
    })
}
