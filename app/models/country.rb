class Country < ActiveRecord::Base
  attr_accessible :country_name, :currency_id, :currency_name, :iso_code, :phone_country_code
  has_many :states, :dependent => :destroy
  has_many :metros, :dependent => :destroy
  
  def name
    self.country_name
  end
end
