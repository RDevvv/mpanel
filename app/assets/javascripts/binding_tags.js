function binding_tags(tracking){
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

            all_buttons = call_buttons.concat(ad_request).concat(description).concat(address);
        }
        else{
            all_buttons = call_buttons.concat(ad_request);
        }
        return all_buttons;
}
