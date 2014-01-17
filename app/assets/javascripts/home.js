function modal_submit(){
    $('.customer-mobile-number-form').submit(function() {
        var valuesToSubmit = $(this).serialize();
        $.ajax({
            url: "/get_mobile_number/1", //'/notifications/4',sumbits it to the given url of the form
            data: valuesToSubmit,
            method: "POST"
        }).success(function(json){
            console.log('success');
            $('.modal').modal('hide');
        });
        return false; // prevents normal behaviour
    });
}


function track(element) {
    customer_uuid = $.cookie("customer_uuid");
    button_class  = $(element).attr("class").split(" ")[0];
    box_element   = $(element).closest('div[class="bdiv"]');
    redirection_url = "get_button_click.json";
    ad_id         = box_element.attr("id");
    outlet_id     = box_element.attr("outlet_id");
    current_link  = window.location.pathname;

    if(button_class=='call')
        {
            redirection_url = 'store_call_details.json';
        }


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
        }).done(function () {
            console.log("done");
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
