function enable_submit(input_field,submit_button){
    $(input_field).keyup(function(){
    $('#latitude').attr('value',0);
    $('#longitude').attr('value',0);
        if($(input_field).attr('value')==""){
            $(submit_button).attr('disabled',true)
            }
            else{
            $(submit_button).attr('disabled',false)
            }
        })
}

