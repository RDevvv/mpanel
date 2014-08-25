class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :tweet_text
      t.integer :retweets
      t.integer :favorite
      t.references :brand

      t.timestamps
    end
    add_index :tweets, :brand_id
  end
end
