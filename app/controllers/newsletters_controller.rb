class NewslettersController < ApplicationController
  respond_to :html

  def show
    @newsletter = Newsletter.find(:id)

    respond_with @newsletter
  end

end