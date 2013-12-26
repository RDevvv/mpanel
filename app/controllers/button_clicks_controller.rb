class ButtonClicksController < ApplicationController
    def get_click
        customer = Customer.where(:uuid => params[:id]).first
        ButtonClick.create(:customer_id => customer.id, :button_class => params[:button_class], :current_link => params[:current_link], :ad_id => params[:ad_id])

        respond_to do |format|
            format.json {render :nothing => true}
        end
    end

  def index
    @button_clicks = ButtonClick.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @button_clicks }
    end
  end

  # GET /button_clicks/1
  # GET /button_clicks/1.json
  def show
    @button_click = ButtonClick.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @button_click }
    end
  end

  # GET /button_clicks/new
  # GET /button_clicks/new.json
  def new
    @button_click = ButtonClick.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @button_click }
    end
  end

  # GET /button_clicks/1/edit
  def edit
    @button_click = ButtonClick.find(params[:id])
  end

  # POST /button_clicks
  # POST /button_clicks.json
  def create
    @button_click = ButtonClick.new(params[:button_click])

    respond_to do |format|
      if @button_click.save
        format.html { redirect_to @button_click, notice: 'Button click was successfully created.' }
        format.json { render json: @button_click, status: :created, location: @button_click }
      else
        format.html { render action: "new" }
        format.json { render json: @button_click.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /button_clicks/1
  # PUT /button_clicks/1.json
  def update
    @button_click = ButtonClick.find(params[:id])

    respond_to do |format|
      if @button_click.update_attributes(params[:button_click])
        format.html { redirect_to @button_click, notice: 'Button click was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @button_click.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /button_clicks/1
  # DELETE /button_clicks/1.json
  def destroy
    @button_click = ButtonClick.find(params[:id])
    @button_click.destroy

    respond_to do |format|
      format.html { redirect_to button_clicks_url }
      format.json { head :no_content }
    end
  end
end
