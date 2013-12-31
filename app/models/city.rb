class City < ActiveRecord::Base
  attr_accessible :city_name, :metro_id, :state_id, :time_zone
  has_many :areas, :dependent => :destroy
  scope :by_name,lambda {|name| where("city_name ilike ?","%#{name}%")}
  
  def name
    city_name
  end
  def country
    state.country
  end
end
