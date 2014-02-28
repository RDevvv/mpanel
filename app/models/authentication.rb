class Authentication < ActiveRecord::Base
  belongs_to :customer
  attr_accessible :uid
end
