class OutletType < ActiveRecord::Base
  attr_accessible :outlet_type_name
  has_many :outlets, :dependent => :destroy
end
