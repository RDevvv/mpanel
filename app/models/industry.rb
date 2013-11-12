class Industry < ActiveRecord::Base
  attr_accessible :industry_name
  has_many :categories, :dependent => :destroy
end
