class Country < ActiveRecord::Base
  attr_accessible :country_name, :currency_id, :currency_name, :iso_code, :phone_country_code
  has_many :state, :dependent => :destroy
  has_many :metro, :dependent => :destroy
end
