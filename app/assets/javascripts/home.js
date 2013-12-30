function track(element) {
    button_class = $(element).attr("class").split(" ")[0];
    ad_id = $(element).closest('div[class="bdiv"]').attr("id");

    tracking_url = "get_button_click/";
    tracking_url += $.cookie("customer_uuid");
    tracking_url += "/";
    tracking_url += button_class;
    tracking_url += "/";
    tracking_url += window.location.pathname.replace("/","-");
    tracking_url += "/";
    tracking_url += ad_id;
    tracking_url += ".json";

    $.ajax({
        url: tracking_url
    }).done(function () {
    })
}

function send_ad(customer_uuid, element)
{
    ad_id = $(element).closest('div[class="bdiv"]').attr("id");
    outlet_id = $(element).closest('div[class="bdiv"]').attr("outlet_id");

    $.ajax({
        url: "set_sms_data.json",
        type: "post",
        data: {
            'customer_uuid': customer_uuid,
            'ad_id': ad_id,
            'outlet_id': outlet_id
        }
    }).done(function () {
        console.log("sms sent");
    })
}
