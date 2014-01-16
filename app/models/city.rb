class City < ActiveRecord::Base
  attr_accessible :city_name, :state_id, :time_zone, :country_id
  has_many :areas, :dependent => :destroy
  scope :by_name,lambda {|name| where("city_name ilike ?","%#{name}%")}
  belongs_to :country
  def name
    city_name
  end
  # def country
  #   state.country
  # end
end
