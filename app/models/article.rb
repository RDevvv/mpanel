class Article < ActiveRecord::Base
  attr_accessible :body, :title

  validates :title, :presence => true
  validates :body, :presence => true

  has_many :comments, :as => :commentable
end
