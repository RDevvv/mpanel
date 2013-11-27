class ApplicationController < ActionController::Base
  protect_from_forgery
  layout :set_layout

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
