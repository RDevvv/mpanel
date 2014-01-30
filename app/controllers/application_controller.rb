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
    elsif controller_name == 'home' && action_name == 'index'
        "home_index"
    elsif controller_name == 'home' && action_name == 'combo_view'
        "desktop"
    elsif controller_name == 'home'
        "listing"
    elsif controller_name == 'campaigns'
        "home_index"
    elsif controller_name == 'customers'
        "home_index"
    elsif controller_name == 'ads'
        "home_index"
    else
        "application"
    end
  end

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied."
    redirect_to root_url
  end
end
