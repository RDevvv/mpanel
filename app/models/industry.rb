class Industry < ActiveRecord::Base
  attr_accessible :industry_name
  has_many :category, :dependent => :destroy
end
