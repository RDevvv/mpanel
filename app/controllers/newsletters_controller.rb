class NewslettersController < ApplicationController
  respond_to :html

  def show
    created_at = params[:created_at]
    @newsletter = Newsletter.where("created_at >= '#{(created_at).to_time.beginning_of_day}' and created_at <= '#{(created_at).to_time.end_of_day}'").last

    respond_with @newsletter
  end

end