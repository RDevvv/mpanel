class FacebookPost < ActiveRecord::Base
  belongs_to :brand
  attr_accessible :comments, :likes, :post_text
end