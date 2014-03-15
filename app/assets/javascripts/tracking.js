function track(element) {
    if($(element).closest('div[class="bdiv"]').length>0)
        box_element   = $(element).closest('div[class="bdiv"]');
    else
        box_element   = $(element).closest('div[class="bdiv"]');

    customer_uuid = $.cookie("customer_uuid");
    button_class  = $(element).attr("class").split(" ")[0];
    redirection_url = "get_button_click.json";
    ad_id         = box_element.attr("id");
    outlet_id     = box_element.attr("outlet_id");
    current_link  = window.location.pathname;

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
    })
}

function bind_tracking(){
    binding_tags_for_tracking = true;
    all_buttons = binding_tags(binding_tags_for_tracking);
    $(all_buttons).click(function(){
        track($(this));
    })
}
