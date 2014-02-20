class LeadsController < ApplicationController
    respond_to :html, :json

    def index
        @leads = Lead.all

        respond_with @leads
    end

    # GET /leads/1
    # GET /leads/1.json
    def show
        @lead = Lead.find(params[:id])

        respond_with @lead
    end

    # GET /leads/new
    # GET /leads/new.json
    def new
        @lead = Lead.new

        respond_with @lead
    end

    # GET /leads/1/edit
    def edit
        @lead = Lead.find(params[:id])
    end

    # POST /leads
    # POST /leads.json
    def create
        @lead = Lead.new(params[:lead])

        @lead.save
        respond_with @lead, :location => leads_path
    end

    # PUT /leads/1
    # PUT /leads/1.json
    def update
        @lead = Lead.find(params[:id])

        @lead.update_attributes(params[:lead])
        respond_with @lead, :location => leads_path
    end

    # DELETE /leads/1
    # DELETE /leads/1.json
    def destroy
        @lead = Lead.find(params[:id])
        @lead.destroy

        respond_with @lead, :location => leads_path
    end
end
