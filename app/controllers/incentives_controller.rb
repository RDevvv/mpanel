class IncentivesController < ApplicationController
    respond_to :html, :json

    def index
        @incentives = Incentive.all

        respond_with @incentives
    end

    def show
        @incentive = Incentive.find(params[:id])

        respond_with @incentive
    end

    def new
        @incentive = Incentive.new

        respond_with @incentive
    end

    # GET /incentives/1/edit
    def edit
        @incentive = Incentive.find(params[:id])
    end

    def create
        @incentive = Incentive.new(params[:incentive])

        @incentive.save
        respond_with @incentive, :location => incentives_path
    end

    def update
        @incentive = Incentive.find(params[:id])

        @incentive.update_attributes(params[:incentive])
        respond_with @incentive, :location => incentives_path
    end

    def destroy
        @incentive = Incentive.find(params[:id])
        @incentive.destroy

        respond_with @incentive, :location => incentives_path
    end
end
