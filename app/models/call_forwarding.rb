class CallForwarding < ActiveRecord::Base
    attr_accessible :customer_id, :call_sid, :from, :to, :direction, :dial_call_duration, :start_time, :end_time, :call_type
    attr_accessible :ad_id, :outlet_id, :digits, :recording_url, :session_id

    belongs_to :outlet
    belongs_to :customer
    # attr_accessible :title, :body
    #validates :from, :numericality => true,:length => {:minimum => 9, :maximum => 11}
    #validates :to, :numericality => true,:length => {:minimum => 9, :maximum => 11}
    #validates :call_sid, :uniqueness => true,:presence => false
end
