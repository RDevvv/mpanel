function send_ad(customer_uuid, element)
{
    closest_search_pattern = 'div[class="bdiv"]'
    if(window.location.href.search('map')>1){
        closest_search_pattern = 'div[class="bdiv2"]'
    }
    if($.cookie("mobile_number")=='verified'){
        customer_uuid = $.cookie("customer_uuid");
        ad_id         = $(element).closest(closest_search_pattern).attr("ad_id");
        outlet_id     = $(element).closest(closest_search_pattern).attr("outlet_id");
        url           = "set_sms_data.json";
        title         = "Offer sent by SMS";

        if(typeof(ad_id) == 'undefined'){
            url = 'sms_share.json';
            title = '';// ;
        }

        $.ajax({
            url: url,
            type: "post",
            dataType: "json",
            data: {
                'customer_uuid': customer_uuid,
                'ad_id': ad_id,
                'outlet_id': outlet_id
            }
        }).success(function (data) {
            if(typeof(ad_id) == 'undefined'){
                data["text"] = 'We have sent you an SMS. Please recommend GullakMaster to your friends.';
            }
            if($.cookie("mobile_number")=="verified")
                $.pnotify({
                    title: title,
                    text: data["text"],
                    sticker_hover: false,
                    closer_hover: false,
                    animate_speed: 'fast',
                    icon: false,
                    opacity: .9
                });
        })
    }
}

function bind_send_ad(){
    binding_tags_for_tracking = true;
    ad_request = $('.ad_request');
    $(ad_request).click(function(){
        send_ad($.cookie('customer_uuid'),$(this));
    })
}
