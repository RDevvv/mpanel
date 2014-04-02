class Category < ActiveRecord::Base
  attr_accessible :category_name, :industry_id,:attachments_attributes
  has_many :brands, :dependent => :destroy
  belongs_to :industry

  validates :category_name, :uniqueness => true, :presence => true
  has_many :attachments, :as => :attachable ,:class_name=>'Attachment'
  accepts_nested_attributes_for :attachments ,allow_destroy: true

  def name
    category_name
  end
end
