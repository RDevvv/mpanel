class Tweet < ActiveRecord::Base
  belongs_to :brand
  attr_accessible :favorite, :retweets, :tweet_text
end
