class ProductLike < ActiveRecord::Base
  belongs_to :product
  belongs_to :customer

  attr_accessible :product_id, :customer_id

  validates :product_id, :presence => true
  validates :customer_id, :presence => true
  after_create :update_product_likes_count

  def update_product_likes_count
      self.product.update_attributes(:product_likes_count => self.product.product_likes_count+1)
      puts self.product.product_likes_count
  end
end
