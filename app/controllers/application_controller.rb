class ApplicationController < ActionController::Base
  protect_from_forgery
  layout :set_layout

  def user_for_paper_trail

    if current_admin_user
      current_admin_user
    else
      'Unknown User'  
    end  
    admin_user_signed_in? ? current_admin_user : 'Unknown user'
  end

  def after_sign_in_path_for(resource)
    # IF it's merchant redirect to merchant page
    if resource.is_a?(User)
      merchant_merchants_path
    else
    super  
    end
  end
  private

  def set_layout
    if devise_controller? && devise_mapping.name == :merchant_user
      "merchant"
    else
      "application"
    end
  end
end
