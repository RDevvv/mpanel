class CustomerSessionsController < ApplicationController
  # GET /customer_sessions
  # GET /customer_sessions.json
  def index
    @customer_sessions = CustomerSession.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @customer_sessions }
    end
  end

  # GET /customer_sessions/1
  # GET /customer_sessions/1.json
  def show
    @customer_session = CustomerSession.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @customer_session }
    end
  end

  # GET /customer_sessions/new
  # GET /customer_sessions/new.json
  def new
    @customer_session = CustomerSession.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @customer_session }
    end
  end

  # GET /customer_sessions/1/edit
  def edit
    @customer_session = CustomerSession.find(params[:id])
  end

  # POST /customer_sessions
  # POST /customer_sessions.json
  def create
    @customer_session = CustomerSession.new(params[:customer_session])

    respond_to do |format|
      if @customer_session.save
        format.html { redirect_to @customer_session, notice: 'Customer session was successfully created.' }
        format.json { render json: @customer_session, status: :created, location: @customer_session }
      else
        format.html { render action: "new" }
        format.json { render json: @customer_session.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /customer_sessions/1
  # PUT /customer_sessions/1.json
  def update
    @customer_session = CustomerSession.find(params[:id])

    respond_to do |format|
      if @customer_session.update_attributes(params[:customer_session])
        format.html { redirect_to @customer_session, notice: 'Customer session was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @customer_session.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customer_sessions/1
  # DELETE /customer_sessions/1.json
  def destroy
    @customer_session = CustomerSession.find(params[:id])
    @customer_session.destroy

    respond_to do |format|
      format.html { redirect_to customer_sessions_url }
      format.json { head :no_content }
    end
  end
end
