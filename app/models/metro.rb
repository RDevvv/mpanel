class Metro < ActiveRecord::Base
  attr_accessible :country_id, :metro_code, :metro_long_name, :metro_name
  has_many :city, :dependent => :destroy
  belongs_to :country
end