namespace :shoffr do
  desc 'fetch user tweets'
  task :tweets => :environment do
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = "KlKJQPU2u4peSTd9SiJ3duuy4"
      config.consumer_secret     = "NK5o5HDkF8cOpelrs9bANyUD8BBcWuZCN0eET7IvK2cjsEXmoa"
      config.access_token        = "19431637-JyBCapOY4OrNIy6w7JWAb85eYk6sFijH1eaius4SY"
      config.access_token_secret = "AtNHdB6gBTBYEwLvATOsfyUd4wbGJb5Vwug7bty1tK0D8"
    end

    Brand.all.each do |brand|
      unless brand.twitter_handle.blank?
        client.user_timeline(brand.twitter_handle).each do |tweet|
          brand.tweets.create(:retweets => tweet.retweeters_count, :favorite => tweet.favorite_count, :tweet_text => tweet.text, :tweet_id => tweet.id)
        end
      end
    end

  end
end
