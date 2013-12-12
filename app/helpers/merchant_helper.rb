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

  def no_sidebar
    classes = {"accounts.new"=>"no_sidebar","accounts.verified_account"=>"no_sidebar"}
      
    unless current_merchant_user
      classes[controller.controller_name + '.' + controller.action_name] || classes[controller.controller_name] || ''
    end  
  end

  def has_sidebar
    classes = {"accounts.new"=>"has_sidebar","accounts.verified_account"=>"has_sidebar"}
      
    if current_merchant_user
      classes[controller.controller_name + '.' + controller.action_name] || classes[controller.controller_name] || ''
    end  
  end

  def display_label_for_activate(active=false)
    if active
      "<span class='label label-success'>De Activate</span>".html_safe
      
    else
      "<span class='label label-info'>Activate</span>".html_safe
    end
  end

  
end
