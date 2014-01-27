module MerchantHelper
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

  def display_label_for_exclusive(exclusive=false)
    if exclusive
      "<span class='label label-success'>Not Exclusive?</span>".html_safe
      
    else
      "<span class='label label-info'>Exclusive</span>".html_safe
    end
  end

  def display_label_for_verify(verify=false)
    if verify
      "<span class='label label-info'>Verified</span>".html_safe      
    else      
      "<span class='label label-warning'>Not Verified</span>".html_safe
    end
  end

  def display_label_for_role(role)
    if role == "admin"
      "<span class='label label-success'>Admin</span>".html_safe
    # elsif role == "owner"
    #   "<span class='label label-success'>Owner</span>".html_safe
    # else
    #   "<span class='label label-info'>User</span>".html_safe
   end
  end

end
