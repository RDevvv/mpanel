ActiveAdmin.register Article do

  index do
    column :id do |article|
      link_to "#{article.id}", admin_article_path(article)
    end
    column :blog_title
    column :blog_category
    column :page_title
    column :blog_url
    column :blog_keywords
    column :summary_image
    column :image_caption
    column :summary_image_caption
    column :image_alt_text
    column :image_title
    column :blog_excerpt
    column :author
    column :author_linkedin_url
    column :social_share_caption
    actions :defaults => true
  end

  form(:html => { :multipart => true }) do |f|
    f.inputs do
      f.input :blog_category
      f.input :page_title
      f.input :blog_title
      f.input :blog_url
      f.input :blog_keywords
      f.input :summary_image
      f.input :image_caption
      f.input :summary_image_caption
      f.input :image_alt_text
      f.input :image_title
      f.input :blog_excerpt
      f.input :blog_body
      f.input :author
      f.input :author_linkedin_url
      f.input :social_share_caption
      f.has_many :attachments do |s|
        s.input :image, :as => :file
      end
    end
    f.actions
  end
end
