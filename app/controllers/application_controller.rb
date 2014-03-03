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
    elsif controller_name == 'home' && action_name == 'admin_panel'
        "admin"
    elsif controller_name == 'home'
        "listing"
    elsif controller_name == 'campaigns' || controller_name == 'customers' || controller_name == 'ads' || controller_name == 'error_messages'
        "home_index"
    else
        "application"
    end
  end

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied."
    redirect_to root_url
  end

  if Rails.env.production?
    unless Rails.application.config.consider_all_requests_local
      rescue_from Exception, with: :render_500
      rescue_from ActionController::RoutingError, with: :render_404
      rescue_from ActionController::UnknownController, with: :render_404
      rescue_from ActionController::UnknownAction, with: :render_404
      rescue_from ActiveRecord::RecordNotFound, with: :render_404
    end
  end

  def render_404(exception)
    @not_found_path = exception.message
    puts"--------------------#{@not_found_path = exception.message}"
    puts"--------------------#{@not_found_path = params[:not_found]}"
    respond_to do |format|
      format.html { render template: 'error_messages/error_404', layout: 'layouts/home_index', status: 404 }
      format.all { render nothing: true, status: 404 }
    end
  end

  def render_500(exception)
    logger.info exception.backtrace.join("\n")
    respond_to do |format|
      format.html { render template: 'error_messages/error_500', layout: 'layouts/home_index', status: 500 }
      format.all { render nothing: true, status: 500}
    end
  end

end
