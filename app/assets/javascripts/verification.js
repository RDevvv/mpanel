function mobile_number_verification(){
    binding_tags_for_tracking = false
    all_buttons = binding_tags(binding_tags_for_tracking);
    $(all_buttons).click(function(){
        console.log("binding works!!!");
        if($.cookie("mobile_number") == 'verified'){}
        else if($.cookie("mobile_number") == 'false'){
            console.log("enter mobile number");
            $('#mobile-number').modal('show');
        }
        else{
            $('#verification').modal('show');
            console.log('verify mobile number');
        }
    })
}
