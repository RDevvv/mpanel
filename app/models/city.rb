class City < ActiveRecord::Base
  attr_accessible :city_name, :metro_id, :state_id, :time_zone
  has_many :area, :dependent => :destroy
  belongs_to :state
  belongs_to :metro
end
