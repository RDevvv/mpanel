function mobile_number_verification(){
    binding_tags_for_tracking = false
    all_buttons = binding_tags(binding_tags_for_tracking);
    $(all_buttons).click(function(){
        if($.cookie("mobile_number") == 'verified'){}
        else if($.cookie("mobile_number") == 'not_verified'){
            $('#verification').modal('show');
            $('#popup_share').modal('hide');
        }
        else if(($.cookie("mobile_number") == 'false')||($.cookie('mobile_number'))||(typeof($.cookie('mobile_number')) == 'undefined')){
            $('#mobile-number').modal('show');
            $('#popup_share').modal('hide');
        }
        else{
            $('#verification').modal('show');
            $('#popup_share').modal('hide');
        }
    })
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
                    $.pnotify({ title: '', text: 'Your account is verified', closer_hover: false, sticker_hover: false, icon: false, opacity: .9 });
                    window.location.reload();
                }
                else{
                    $.pnotify({ title: '', text: 'Please enter correct verification code.', closer_hover: false, sticker_hover: false, icon: false, opacity: .9 });
                }
        });
        return false; // prevents normal behaviour
    });
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
                        if($.cookie('mobile_number')=='not_verified'){
                            console.log('iffffffffffff');
                            $('#verification').modal('show');
                            $('#mobile-number').modal('hide');
                        }
                        else{
                            console.log('elseeeeeeeeeeeeeeeeeee');
                            $.pnotify({ title: '', text: 'Welcome back', closer_hover: false, sticker_hover: false, icon: false, opacity: .9 });
                            $('#mobile-number').modal('hide');
                            window.location.reload();
                        }
                    }
                    else
                        {
                            $.pnotify({ title: '', text: 'Enter a valid mobile number', closer_hover: false, sticker_hover: false, icon: false, opacity: .9 });
                        }
        });
        return false; // prevents normal behaviour
    });
}
