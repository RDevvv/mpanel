class City < ActiveRecord::Base
  attr_accessible :city_name, :state_id, :time_zone, :country_id
  has_many :areas, :dependent => :destroy
  scope :by_name,lambda {|name| where("city_name ilike ?","%#{name}%")}
  belongs_to :country

  validates :city_name, :uniqueness => true, :presence => true

  def name
    city_name
  end

  geocoded_by :geocoding_address

  def geocoding_address
      self.city_name+' ,'+self.country.country_name
  end
end
