class LocationCache < ActiveRecord::Base
  attr_accessible :latitude, :location, :longitude

  validates :latitude, :presence => true
  validates :longitude, :presence => true
  validates :location, :presence => true
end
