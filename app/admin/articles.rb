ActiveAdmin.register Article do

  index do
    column :id do |article|
      link_to "#{article.id}", admin_article_path(article)
    end
    column :page_title
    column :blog_title
    column :blog_category
    column :blog_url
    column :blog_keywords
    column :blog_excerpt
    column :author
    column :author_linkedin_url
    column :social_share_caption
    column :twitter_blockquote
    column :image_title
    column :image_alt_text
    column :image_caption
    column :summary_image_caption
    actions :defaults => true
  end

  form(:html => { :multipart => true }) do |f|
    f.inputs do
      f.input :page_title
      f.input :blog_title
      f.input :blog_category
      f.input :blog_url
      f.input :blog_keywords
      f.input :blog_excerpt
      f.input :author
      f.input :author_linkedin_url
      f.input :social_share_caption
      f.input :twitter_blockquote
      f.input :blog_body
      f.input :image_title
      f.input :image_alt_text
      f.input :image_caption
      f.input :summary_image_caption
      f.has_many :attachments do |s|
        s.input :image, :as => :file
      end
    end
    f.actions
  end
end
