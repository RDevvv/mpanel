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

