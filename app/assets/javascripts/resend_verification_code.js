function resend_verification_code(){
    $.ajax({
        url: '/resend_verification_code.json',
        data: {
            customer_uuid: $.cookie("customer_uuid")
        }
    }).success(function(data){
        console.log(data["success"]);
            if(data["success"]==true)
                $.pnotify({
                    closer_hover: false,
                    sticker_hover: false,
                    icon: false,
                    title: "verification code sent"
                })
        })
}
