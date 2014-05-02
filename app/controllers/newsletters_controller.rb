class NewslettersController < ApplicationController
  respond_to :html

  def show
    @newsletter = Newsletter.where(:created_at == (params[:created_at]).to_time).last

    respond_with @newsletter
  end

end