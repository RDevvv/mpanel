class CallButtonSelect < ActiveRecord::Base
  belongs_to :customer

  attr_accessible :customer_id
end
