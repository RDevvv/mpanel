class CallForwarding < ActiveRecord::Base
	attr_accessible :call_sid, :from, :to, :direction, :dial_call_duration, :start_time, :end_time, :call_type, :digits, :recording_url
  belongs_to :outlet
  belongs_to :customer
  # attr_accessible :title, :body
end
