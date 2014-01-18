class Comment < ActiveRecord::Base
  attr_accessible :article_id, :body, :title, :commentable_id, :commentable_type

  validates :title, :presence => true
  validates :body, :presence => true

  belongs_to :commentable, :polymorphic => true
end
