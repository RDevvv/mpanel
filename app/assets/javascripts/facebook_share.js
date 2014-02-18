function facebook_share_binding(){
    console.log("aaaaaaaaa");
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

    customer_uuid = $.cookie("customer_uuid");
    button_class  = $(element).attr("class").split(" ")[0];
    redirection_url = "get_button_click.json";
    ad_id         = box_element.attr("id");
    outlet_id     = box_element.attr("outlet_id");
    current_link  = window.location.pathname;
    $.ajax({
        url: 'get_campaign_details.json',
        type: 'post',
        data: {
            'customer_uuid': customer_uuid,
            'ad_id': ad_id,
            'outlet_id': outlet_id,
        }
    }).success(function(data){
        caption     = "Get amazing offers for "+data["category_name"];
        description = data["brand_name"]+": "+data["ad_title"]+". Check it out!";
        FB.ui({
            method: 'feed',
            link: 'http://www.gullakmaster.com/',
            caption: caption,
            picture: data["image_url"],
            description: description,
            properties: {link: "http://gullakmaster.com/"}
        }, function(response){});
    })


}














