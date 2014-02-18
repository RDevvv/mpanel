function binding_tags(tracking){
    sms_share_link = $('.sms_share_link');
    sms_share_link = $.makeArray(sms_share_link);
    console.log(sms_share_link);


    call_buttons = $('.call');
    call_buttons = $.makeArray(call_buttons);

    ad_request = $('.ad_request');
    ad_request = $.makeArray(ad_request);

    if(tracking == true)
        {
            address = $('.address');
            address = $.makeArray(address);

            description = $('.description');
            description = $.makeArray(description);

            all_buttons = call_buttons.concat(ad_request).concat(description).concat(address).concat(sms_share_link);
        }
        else{
            all_buttons = call_buttons.concat(ad_request).concat(sms_share_link);
        }
        console.log(all_buttons);
        return all_buttons;
}
