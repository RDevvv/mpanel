var GL = GL || {};
GL = (function($, window, document, Gullak){

  Gullak.outlet = {
    importOutlet : function(){
      $("form.outlet_form").on("submit",function(e){
        var ajaxOptions = {
          url: $(this).attr('action'),
          type:'POST',
          data: $(this).serialize(),
          dataType:'json'
        };
        $.ajax(ajaxOptions).success(function(response){
          if(response.success == false){
            Gullak.outlet.displayImportFormError(response.errors,response.row_id)
          }
          else{
            selector = $("#outlet_"+response.row_id)
            selector.find(".error").text("");
            selector.find("#outlet_submit_"+response.row_id).html("Live");
          }
         });
        return false;
      })
    },
    displayImportFormError : function(errors,row_id){
      var selector = $("#outlet_"+row_id)
      if(errors.pincode)
        selector.find(".pincode_error").text(errors.pincode[0])
      if(errors.area)
        selector.find(".area_name_error").text(errors.area[0])
      if(errors.email_id)
        selector.find(".email_id_error").text(errors.email_id[0])
      if(errors.mobile_number)
        selector.find(".mobile_number_error").text(errors.mobile_number[0])
      if(errors.phone_number)
      selector.find("phone_number_error").text(errors.phone_number[0])
    }

  }
  return Gullak;
})(jQuery, this, this.document, GL);


