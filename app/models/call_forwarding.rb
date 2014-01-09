class CallForwarding < ActiveRecord::Base
	attr_accessible :call_sid, :from, :to, :direction, :dial_call_duration, :start_time, :end_time, :call_type, :digits, :recording_url
  belongs_to :outlet
  belongs_to :customer
  # attr_accessible :title, :body

  def get_all_parameters(path)
  	CallForwarding.create(:from=>path["From"],:to=>path["to"],:direction=>path["Direction"],:dial_call_duration=>path["DialCallDuration"],:start_time=>path["StartTime"],:end_time=>path["EndTime"], :call_type=>path["CallType"],:digits=>path["digits"])
		return "Success"  	
  end

end
