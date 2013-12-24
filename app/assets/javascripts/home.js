function track(element) {
    check_class = $(element).attr("class");
    if (check_class == "button_call2") {
        console.log("within if condition");
        $.ajax({
            url: "get_call_click/".concat($.cookie("customer_uuid")).concat(".json")
        }).done(function () {
            console.log("vivekkkkkk");
        })
    }
    else //if(check_class=="button_map2")
        {
            console.log("within else condition");
            $.ajax({
                url: "get_button_click/".concat($.cookie("customer_uuid")).concat("/").concat(check_class).concat(".json")
                //add window.location.pathname to to given string
            }).done(function () {
            })
        }

}

