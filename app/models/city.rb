class City < ActiveRecord::Base
  attr_accessible :city_name, :metro_id, :state_id, :time_zone
  has_many :areas, :dependent => :destroy
  belongs_to :state
  belongs_to :metro

  
  def name
    city_name
  end
end
