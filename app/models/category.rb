class Category < ActiveRecord::Base
  attr_accessible :category_name, :industry_id
  has_many :brands, :dependent => :destroy
  belongs_to :industry

  validates :category_name, :uniqueness => true, :presence => true

  def name
    category_name
  end
end
