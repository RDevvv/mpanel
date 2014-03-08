class ErrorMessagesController < ApplicationController

  def error_404
    @current_session_id = Customer.where(:uuid => cookies[:customer_uuid]).first.customer_sessions.order(:id).last.id
    @not_found_path = params[:not_found]
  end

  def error_422

  end

  def error_500
    @current_session_id = Customer.where(:uuid => cookies[:customer_uuid]).first.customer_sessions.order(:id).last.id
  end


end
