class Product < ActiveRecord::Base
    belongs_to :account_brand
    has_many :attachments, :as => :attachable ,:class_name=>'Attachment'
    has_many :product_likes
    has_many :product_comments

    attr_accessible :description, :name, :price, :account_brand_id, :attachments_attributes, :product_likes_count, :product_comments_count
    accepts_nested_attributes_for :attachments ,allow_destroy: true

    validates :name, :presence => true
    validates :description, :presence => true
    validates :price, :presence => true
    validates :attachments, :presence => true
end
