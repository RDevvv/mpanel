class Comment < ActiveRecord::Base
  attr_accessible :article_id, :body, :title
end
