class PaymentValue < ActiveRecord::Base
  attr_accessible :catchment_radius, :currency_id, :value
  has_many :outlet, :dependent => :destroy
end
