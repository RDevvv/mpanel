class Article < ActiveRecord::Base
  attr_accessible :body, :title, :attachments_attributes

  has_many :attachments, :as => :attachable ,:class_name=>'Attachment'
  accepts_nested_attributes_for :attachments ,allow_destroy: true
  has_many :comments, :as => :commentable
end
