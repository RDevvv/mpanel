class ButtonClick < ActiveRecord::Base
  belongs_to :customer
  attr_accessible :ad_id, :button_class, :customer_id, :session_id, :current_link

  belongs_to :ad
end
