ActiveAdmin.register Newsfeed do

  form(:html => { :multipart => true }) do |f|
    f.inputs do
      f.input :news_title
      f.input :news_type, :as => :select, :collection => [["CURATED NEWS","CURATED NEWS"], ["SHOFFR IN THE NEWS","SHOFFR IN THE NEWS"]]
      f.input :news_excerpt
      f.input :news_url
      f.input :journal_name
      f.input :journal_url
      f.input :image_title
      f.input :image_caption
      f.input :image_alt_text
      f.has_many :attachments do |s|
        s.input :image, :as => :file
      end
    end
    f.actions
  end
  
end
