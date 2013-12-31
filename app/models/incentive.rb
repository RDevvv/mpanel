class Incentive < ActiveRecord::Base
  attr_accessible :expiry_date, :is_active, :name, :sms_text
end
