class ButtonClick < ActiveRecord::Base
  belongs_to :customer
  attr_accessible :ad_id, :button_class, :customer_id
end
