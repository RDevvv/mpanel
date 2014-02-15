function show_share(facebook_share_link){
    $('#popup_share').modal('show');
    parent_element = $(facebook_share_link).parent().parent().parent();
    window.poster_id = parent_element;
    $.ajax({
        url: "/generate_campaign_copy.json",
        data: {
            ad_id: parent_element.attr("ad_id"),
            outlet_id: parent_element.attr("outlet_id")
        },
        method: 'POST'

    }).success(function(data){
        $('.facebook_share').attr('href', 'https://www.facebook.com/sharer/sharer.php?u=http://'+document.domain+'/'+data["short_url"]);
        $('.facebook_share').attr('target', '_blank');
    })
}

function new_sms_share(sms_share_link){
    parent_element = window.poster_id;
    console.log(window.poster_id);
    console.log(parent_element);
    $.ajax({
        url: "/sms_share.json",
        data:{
            customer_uuid: $.cookie("customer_uuid"),
            ad_id: parent_element.attr("ad_id"),
            outlet_id: parent_element.attr("outlet_id")
        }
    }).success(function(){
        $.pnotify({ title: '', text: 'Ad sent', closer_hover: false, opacity: .9 });
    })
}
