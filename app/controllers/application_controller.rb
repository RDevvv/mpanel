class ApplicationController < ActionController::Base
  protect_from_forgery
  layout :set_layout

  private
  

  def set_layout

    if devise_controller? && devise_mapping.name == :merchant_user
      "merchant"
    else
      "application"
    end
  end
end
