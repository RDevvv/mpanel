class MissedCallsController < ApplicationController
    def get_missed_call
        @missed_call = MissedCall.create(:call_sid=>params["CallSid"],:from=>params[:CallFrom],:to=>params["CallTo"])
        render :json => 'OK', :status => '200'
    end
end
