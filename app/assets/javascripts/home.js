function track(element) {
    customer_uuid = $.cookie("customer_uuid");
    button_class  = $(element).attr("class").split(" ")[0];
    box_element   = $(element).closest('div[class="bdiv"]');
    ad_id         = box_element.attr("id");
    outlet_id     = box_element.attr("outlet_id");
    current_link  = window.location.pathname;


    $.ajax({
        url: "get_button_click.json",
        type: "post",
        data: {
            'customer_uuid': customer_uuid,
            'ad_id': ad_id,
            'outlet_id': outlet_id,
            'button_class': button_class,
            'current_link': current_link
        }
    }).done(function () {
    })
}

function send_ad(customer_uuid, element)
{
    customer_uuid = $.cookie("customer_uuid");
    ad_id         = $(element).closest('div[class="bdiv"]').attr("id");
    outlet_id     = $(element).closest('div[class="bdiv"]').attr("outlet_id");

    $.ajax({
        url: "set_sms_data.json",
        type: "post",
        dataType: "json",
        data: {
            'customer_uuid': customer_uuid,
            'ad_id': ad_id,
            'outlet_id': outlet_id
        }
    }).success(function (data) {
        //string = JSON.parse(data);
        if(data["mobile_number_presence"] == false)
            {
                window.location.replace("/customers/"+data["customer_id"]+"/edit")
            }

    }).fail(
    function(data){
        console.log("failure");
    })
}
