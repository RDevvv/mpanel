class NewslettersController < ApplicationController
  respond_to :html

  def show
    created_at = params[:created_at].to_time
    @newsletter = Newsletter.where(:created_at => created_at).first
    binding.pry
    respond_with @newsletter
  end

end