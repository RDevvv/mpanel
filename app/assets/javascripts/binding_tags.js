function binding_tags(tracking){
    sms_share_link = $('.sms_share_link');
    sms_share_link = $.makeArray(sms_share_link);

    email_share_link = $('.email_share');
    email_share_link = $.makeArray(email_share_link);

    call_buttons = $('.call');
    call_buttons = $.makeArray(call_buttons);

    ad_request = $('.ad_request');
    ad_request = $.makeArray(ad_request);

    view_buttons = $('.button_view');
    view_buttons = $.makeArray(view_buttons);

    share_buttons = $('.share');
    share_buttons = $.makeArray(share_buttons);

    if(tracking == true){
        address = $('.address');
        address = $.makeArray(address);

        description = $('.description');
        description = $.makeArray(description);

        all_buttons = call_buttons.concat(ad_request).concat(description).concat(address).concat(sms_share_link).concat(view_buttons).concat(share_buttons).concat(email_share_link);
        console.log(view_buttons);
    }
    else{
        all_buttons = call_buttons.concat(ad_request).concat(sms_share_link);
    }
    return all_buttons;
}
