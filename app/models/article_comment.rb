class ArticleComment < ActiveRecord::Base
  attr_accessible :comment, :commentable_id, :commentable_type, :email, :name
end
