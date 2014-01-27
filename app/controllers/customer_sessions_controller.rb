class CustomerSessionsController < ApplicationController
  def index
    @customer_sessions = CustomerSession.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @customer_sessions }
    end
  end

  def show
    @customer_session = CustomerSession.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @customer_session }
    end
  end
end
