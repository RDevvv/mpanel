function call_button(){
    call_buttons = $('.call');
    for(i=0;i<call_buttons.length;i++){
        $(call_buttons[i]).attr('href','tel:09223584822');
    }
}
