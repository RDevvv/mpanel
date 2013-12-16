class CallButtonSelectsController < ApplicationController

    def get_click
        customer = Customer.where(:uuid => params[:id]).first
        CallButtonSelect.create(:customer_id => customer.id)

        respond_to do |format|
            format.json {render :nothing => true}
        end
    end

    def index
        @call_button_selects = CallButtonSelect.all

        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @call_button_selects }
        end
    end

    # GET /call_button_selects/1
    # GET /call_button_selects/1.json
    def show
        @call_button_select = CallButtonSelect.find(params[:id])

        respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @call_button_select }
        end
    end

    # GET /call_button_selects/new
    # GET /call_button_selects/new.json
    def new
        @call_button_select = CallButtonSelect.new

        respond_to do |format|
            format.html # new.html.erb
            format.json { render json: @call_button_select }
        end
    end

    # GET /call_button_selects/1/edit
    def edit
        @call_button_select = CallButtonSelect.find(params[:id])
    end

    # POST /call_button_selects
    # POST /call_button_selects.json
    def create
        @call_button_select = CallButtonSelect.new(params[:call_button_select])

        respond_to do |format|
            if @call_button_select.save
                format.html { redirect_to @call_button_select, notice: 'Call button select was successfully created.' }
                format.json { render json: @call_button_select, status: :created, location: @call_button_select }
            else
                format.html { render action: "new" }
                format.json { render json: @call_button_select.errors, status: :unprocessable_entity }
            end
        end
    end

    # PUT /call_button_selects/1
    # PUT /call_button_selects/1.json
    def update
        @call_button_select = CallButtonSelect.find(params[:id])

        respond_to do |format|
            if @call_button_select.update_attributes(params[:call_button_select])
                format.html { redirect_to @call_button_select, notice: 'Call button select was successfully updated.' }
                format.json { head :no_content }
            else
                format.html { render action: "edit" }
                format.json { render json: @call_button_select.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /call_button_selects/1
    # DELETE /call_button_selects/1.json
    def destroy
        @call_button_select = CallButtonSelect.find(params[:id])
        @call_button_select.destroy

        respond_to do |format|
            format.html { redirect_to call_button_selects_url }
            format.json { head :no_content }
        end
    end
end
