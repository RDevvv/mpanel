class Product < ActiveRecord::Base
    belongs_to :account_brand
    attr_accessible :description, :name, :price, :account_brand_id

    has_many :attachments, :as => :attachable ,:class_name=>'Attachment'
    accepts_nested_attributes_for :attachments ,allow_destroy: true

    validates :name, :presence => true
    validates :description, :presence => true
    validates :price, :presence => true
end
