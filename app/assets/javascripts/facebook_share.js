function facebook_share_binding(){
    share_buttons = $('.share');
    $(share_buttons).click(function(){
        facebook_share($(this));
    });
    $('.top_share').click(function(){
        facebook_share($(this));
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
        console.log(data['image_url'])
        if(button_class == 'top_share'){
            caption     = 'Deals At Your Fingertips!';
            description = "Discover nearby deals on Accessories, Apparel, Electronics, Food, Mobiles, Shoes... Save time, energy, and money at the click of a button. Happy shopping you'al!";
            marketer    = true;
        }
        else{
            caption     = data['category_name']+' - Deals At Your Fingertips!';
            description = 'Discover nearby deals for '+data['category_name']+' Currently '+data["brand_name"]+" has the following deal: "+data["ad_title"]+". Save time, energy, and money at the click of a button. Happy shopping you'al!";
            marketer    = false;
        }
        link        = current_domain+'/'+data["short_url"]
        FB.ui({
            method: 'feed',
            name: 'GullakMaster',
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

function update_top_share_url(element){
    customer_uuid   = $.cookie("customer_uuid");
    button_class    = $(element).attr("class").split(" ")[0];
    redirection_url = "get_button_click.json";
    current_domain  = window.location.origin;
    $.ajax({
        url: 'get_campaign_details.json',
        type: 'post',
        data: {
            'customer_uuid': customer_uuid,
            'button_class': button_class,
        }
    }).success(function(data){
        $('#top_share_link').attr('value','gullak.co/'+data['short_url'])
    })
}
