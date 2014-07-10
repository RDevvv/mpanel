class CustomerLocation < ActiveRecord::Base
  belongs_to :customer

  attr_accessible :latitude, :longitude, :customer_id
end
