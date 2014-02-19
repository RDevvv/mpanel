function facebook_share_binding(){
    share_buttons = $('.share');
    $(share_buttons).click(function(){
        facebook_share($(this));
        console.log($(this));
    });
}

function facebook_share(element){
    if($(element).closest('div[class="bdiv"]').length>0)
        box_element   = $(element).closest('div[class="bdiv"]');
    else
        box_element   = $(element).closest('div[class="bdiv2"]');

    customer_uuid   = $.cookie("customer_uuid");
    button_class    = $(element).attr("class").split(" ")[0];
    redirection_url = "get_button_click.json";
    ad_id           = box_element.attr("ad_id");
    outlet_id       = box_element.attr("outlet_id");
    current_domain  = window.location.origin;
    $.ajax({
        url: 'get_campaign_details.json',
        type: 'post',
        data: {
            'customer_uuid': customer_uuid,
            'ad_id': ad_id,
            'button_class': button_class,
            'outlet_id': outlet_id,
        }
    }).success(function(data){
        if(button_class = 'top_share'){
            caption     = 'GullakMaster | Deals At Your Fingertips!';
            description = 'Tell GullakMaster your location and they pull together amazing deals from nearby stores right on your phone.You really have to check it out.';
        }
        else{
            caption     = 'Get amazing offers for '+data["category_name"];
            description = data["brand_name"]+": "+data["ad_title"]+". Check it out!";
        }
        link        = current_domain+'/'+data["short_url"]
        FB.ui({
            method: 'feed',
            link: link,
            caption: caption,
            picture: data["image_url"],
            description: description,
            properties: {link: "http://gullakmaster.com/"}
        }, function(response){});
    })
}
