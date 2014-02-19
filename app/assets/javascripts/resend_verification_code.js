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
                    title: "verification code sent"
                })
        })
}
