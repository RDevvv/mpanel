class ArticleComment < ActiveRecord::Base
  attr_accessible :comment, :commentable_id, :commentable_type, :email, :name

  belongs_to :commentable, :polymorphic => true
  validates_presence_of :comment
  validates_presence_of :email
  validates_presence_of :name
end
