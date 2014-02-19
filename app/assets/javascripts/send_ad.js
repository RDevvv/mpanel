function send_ad(customer_uuid, element)
{
    if($.cookie("mobile_number")=='verified'){
        customer_uuid = $.cookie("customer_uuid");
        ad_id         = $(element).closest('div[class="bdiv"]').attr("id");
        outlet_id     = $(element).closest('div[class="bdiv"]').attr("outlet_id");
        url           = "set_sms_data.json";
        title         = "Ad sent";

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
