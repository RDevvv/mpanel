class ButtonClick < ActiveRecord::Base
  belongs_to :customer
  belongs_to :ad

  attr_accessible :ad_id, :outlet_id, :button_class, :customer_id, :session_id, :previous_link, :current_link

  validates :button_class, :presence => true
  validates :previous_link, :presence => true
  validates :current_link, :presence => true
end
