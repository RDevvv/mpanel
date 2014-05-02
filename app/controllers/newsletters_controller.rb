class NewslettersController < ApplicationController
  respond_to :html

  def show
    created_at = params[:created_at]
    @newsletter = Newsletter.where("created_at >= '#{(created_at).to_time}' and created_at <= '#{(created_at+(1.to_s)).to_time}'").last

    respond_with @newsletter
  end

end