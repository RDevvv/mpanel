class CreateNewsfeeds < ActiveRecord::Migration
  def change
    create_table :newsfeeds do |t|
      t.string :news_type
      t.string :journal_name
      t.string :journal_url
      t.string :image_caption
      t.string :image_alt_text
      t.string :image_title
      t.string :news_title
      t.string :news_excerpt
      t.string :news_url

      t.timestamps
    end
  end
end
