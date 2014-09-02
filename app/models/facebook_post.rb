class FacebookPost < ActiveRecord::Base
  belongs_to :brand
  attr_accessible :comments, :likes, :post_text, :facebook_post_id, :image_url, :post_url

  validates :facebook_post_id, :uniqueness => true
end
