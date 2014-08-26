class Tweet < ActiveRecord::Base
  belongs_to :brand
  attr_accessible :favorite, :retweets, :tweet_text, :tweet_id

  validates :tweet_id, :uniqueness => true
end
