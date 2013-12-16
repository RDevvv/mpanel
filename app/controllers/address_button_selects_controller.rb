class AddressButtonSelectsController < ApplicationController
  # GET /address_button_selects
  # GET /address_button_selects.json
  def index
    @address_button_selects = AddressButtonSelect.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @address_button_selects }
    end
  end

  # GET /address_button_selects/1
  # GET /address_button_selects/1.json
  def show
    @address_button_select = AddressButtonSelect.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @address_button_select }
    end
  end

  # GET /address_button_selects/new
  # GET /address_button_selects/new.json
  def new
    @address_button_select = AddressButtonSelect.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @address_button_select }
    end
  end

  # GET /address_button_selects/1/edit
  def edit
    @address_button_select = AddressButtonSelect.find(params[:id])
  end

  # POST /address_button_selects
  # POST /address_button_selects.json
  def create
    @address_button_select = AddressButtonSelect.new(params[:address_button_select])

    respond_to do |format|
      if @address_button_select.save
        format.html { redirect_to @address_button_select, notice: 'Address button select was successfully created.' }
        format.json { render json: @address_button_select, status: :created, location: @address_button_select }
      else
        format.html { render action: "new" }
        format.json { render json: @address_button_select.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /address_button_selects/1
  # PUT /address_button_selects/1.json
  def update
    @address_button_select = AddressButtonSelect.find(params[:id])

    respond_to do |format|
      if @address_button_select.update_attributes(params[:address_button_select])
        format.html { redirect_to @address_button_select, notice: 'Address button select was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @address_button_select.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /address_button_selects/1
  # DELETE /address_button_selects/1.json
  def destroy
    @address_button_select = AddressButtonSelect.find(params[:id])
    @address_button_select.destroy

    respond_to do |format|
      format.html { redirect_to address_button_selects_url }
      format.json { head :no_content }
    end
  end
end
