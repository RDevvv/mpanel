class CustomerFeedback < ActiveRecord::Base
  belongs_to :customer
  attr_accessible :email, :feedback, :link

  validates :email, :presence => true, :format => /@/
  validates :feedback, :presence => true
end
