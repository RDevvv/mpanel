function facebook_share_binding(){
    share_buttons = $('.share');
    $(share_buttons).click(function(){
        check_facebook_authentication($(this));
    });
}

function check_facebook_authentication(element){
    if($.cookie('facebook_auth')== 'true'){
        facebook_share(element);
    }
    else{
        window.open('/auth/facebook');
    }
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
        if(button_class == 'top_share'){
            caption     = 'Deals At Your Fingertips!';
            description = "Shopping just got better. Identify your location to GullakMaster and discover nearby deals on Accessories, Apparel, Electronics, Food, Mobiles, Shoes... You can locate the stores on a map and even call the store directly. Save time, energy, and money at the click of a button. Happy shopping you'al!";
            marketer    = true;
        }
        else{
            caption     = 'Get amazing offers for '+data["category_name"];
            description = data["brand_name"]+": "+data["ad_title"]+". Check it out!";
            marketer    = false;
        }
        link        = current_domain+'/'+data["short_url"]
        FB.ui({
            method: 'feed',
            link: link,
            caption: caption,
            picture: data["image_url"],
            description: description,
            actions: {
                name: "GullakMaster",
                link: link
            }
        }, function(response){
            $.ajax({
                url: 'update_vendor_id',
                data:{
                    post_id: response["post_id"],
                    marketer: marketer,
                    ad_id: ad_id,
                    outlet_id: outlet_id
                }
            })
        });
    })
}
