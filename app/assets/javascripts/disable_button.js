function enable_submit(input_field,submit_button){
    $(input_field).keyup(function(){
        if($(input_field).attr('value')==""){
            $(submit_button).attr('disabled',true)
            }
            else{
            $(submit_button).attr('disabled',false)
            }
        })
}

