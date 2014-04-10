class AddDetailsToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :blog_category, :string
    add_column :articles, :page_title, :string
    add_column :articles, :blog_title, :string
    add_column :articles, :blog_url, :string
    add_column :articles, :blog_keywords, :string
    add_column :articles, :summary_image, :string
    add_column :articles, :image_caption, :string
    add_column :articles, :summary_image_caption, :string
    add_column :articles, :image_alt_text, :string
    add_column :articles, :image_title, :string
    add_column :articles, :blog_excerpt, :string
    add_column :articles, :blog_body, :text
    add_column :articles, :author, :string
    add_column :articles, :author_linkedin_url, :string
    add_column :articles, :social_share_caption, :string
  end
end
