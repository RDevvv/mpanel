class CallForwarding < ActiveRecord::Base
  attr_accessible :customer_id, :call_sid, :from, :to, :direction, :dial_call_duration, :start_time, :end_time, :call_type
  attr_accessible :ad_id, :outlet_id, :digits, :recording_url, :session_id

  belongs_to :outlet
  belongs_to :customer
  # attr_accessible :title, :body
  #validates :from, :numericality => true,:length => {:minimum => 9, :maximum => 11}
  #validates :to, :numericality => true,:length => {:minimum => 9, :maximum => 11}
  #validates :call_sid, :uniqueness => true,:presence => false

  def compare_call_forwarding_number_with_exotel
  	call_forwarding = CallForwarding.last
  	cust_id = call_forwarding.customer_id
  	customer = Customer.find(cust_id)
  	call_forwardings = customer.call_forwardings
  	call_forwardings.pluck(:from).each do |from|
  		if from ==call_forwarding.from
  			#fetch outlet
  		end
  	end
  end
    
end
