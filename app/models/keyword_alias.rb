class KeywordAlias < ActiveRecord::Base
  attr_accessible :alias_name, :keyword_id
  belongs_to :keyword
end
