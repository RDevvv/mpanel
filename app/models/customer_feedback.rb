class CustomerFeedback < ActiveRecord::Base
  belongs_to :customer
  attr_accessible :email, :feedback, :link
end
