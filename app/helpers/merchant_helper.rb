module MerchantHelper
  def active_class_for_sidebar(class_name="home")

    classes = {
      "accounts"=>"account",
      "account_brands"=>"brand",
      "brands"=>"brand",
    }
    if class_name == (classes[controller.controller_name + '.' + controller.action_name] || classes[controller.controller_name] || '')
      "btn-primary" 
    else
      "btn-success" 
    end
  end

  
end
