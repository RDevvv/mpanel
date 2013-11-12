class State < ActiveRecord::Base
  attr_accessible :country_id, :state_code, :state_code, :state_name
  has_many :cities, :dependent => :destroy
  belongs_to :country
end
