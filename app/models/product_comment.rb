class ProductComment < ActiveRecord::Base
  belongs_to :customer
  belongs_to :product

  attr_accessible :comment, :product_id, :customer_id

  validates :product_id, :presence => true
  validates :customer_id, :presence => true

  after_create :update_product_comments_count

  def update_product_comments_count
      self.product.update_attributes(:product_comments_count => self.product.product_comments_count+1)
  end
end
