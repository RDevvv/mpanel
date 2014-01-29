class MissedCallsController < ApplicationController
    def get_missed_call
        @missed_call = MissedCall.create(:from => params[:From], :to => params[:To], :call_sid => params[:Call_Sid])
        render :json => 'OK', :status => '200'
    end
end
