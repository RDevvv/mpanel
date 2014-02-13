function already_have_verification_code(){
    $('#mobile-number').modal('hide');
    $('#verification').modal('show');
}

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


function modal_submit(){
    $('.customer-mobile-number-form').submit(function() {
        var valuesToSubmit = $(this).serialize();
        $.ajax({
            url: "/get_mobile_number/1", //'/notifications/4',sumbits it to the given url of the form
            dataType: 'text',
            data: valuesToSubmit,
            method: 'POST'
        }).success(function(data){
            data = JSON.parse(data);
            if(data["mobile_number"]==1)
            {
                $('#mobile-number').modal('hide');
                $('#verification').modal('show');
            }
            else if(data["mobile_number"]=="exist")
            {
                $.pnotify({ title: '', text: 'Welcome back', closer_hover: false, opacity: .9 });
                $('#mobile-number').modal('hide');
                window.location.reload();
            }
            else
            {
                $.pnotify({ title: '', text: 'Enter a valid mobile number', closer_hover: false, opacity: .9 });
            }
        });
        return false; // prevents normal behaviour
    });
}

function verification_modal_submit(){
    $('.customer-verification-code-form').submit(function() {
        var valuesToSubmit = $(this).serialize();
        $.ajax({
            url: "/check_verification_code", //'/notifications/4',sumbits it to the given url of the form
            dataType: 'text',
            data: valuesToSubmit,
            method: 'POST'
        }).success(function(data){
            data = JSON.parse(data)
            if(data["verified"]==true)
                {
                    $('#verification').modal('hide');
                    $.pnotify({ title: '', text: 'Your account is verified', closer_hover: false, opacity: .9 });
                    window.location.reload();
                }
                else{
                    $.pnotify({ title: '', text: 'Please enter correct verification code.', closer_hover: false, opacity: .9 });
                }
        });
        return false; // prevents normal behaviour
    });
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
        if((data["mobile_number_presence"] == false)&&data["exist_but_not_verified"])
            $('#verification').modal('show');
        else if ((data["mobile_number_presence"] == false))
            $('#mobile-number').modal('show');
        else
            $.pnotify({
                title: 'ad sent',
                text: data["text"],
                closer_hover: false,
                opacity: .9
            });

    })
}

function verify_number(){
    customer_uuid = $.cookie("customer_uuid");
    $.ajax({
        url: 'check_verification_code',
        type: 'post',
        dataType: 'json',
        data: {
            'customer_uuid': customer_uuid
        }
    })
}


function call_button_verification(){
    console.log($.cookie("mobile_number"));
    if($.cookie("mobile_number")=='not_verified'){
        console.log("phone_number");
        $('#verification').modal('show');
    }
    if($.cookie("mobile_number")=='false'){
        console.log("phone_number");
        $('#mobile-number').modal('show');
    }
    else
        console.log("true");
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
