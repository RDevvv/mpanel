ActiveAdmin.register Newsletter do

  index do
    column :id do |newsletter|
      link_to "#{newsletter.id}", admin_newsletter_path(newsletter)
    end
    column (:newsletter_body) {|a| CGI.unescapeHTML(a.newsletter_body).html_safe}
    actions :defaults => true
  end

  show do
    attributes_table do
      row :id
      row (:newsletter_body) {|a| CGI.unescapeHTML(a.newsletter_body).html_safe}
      row :created_at
      row :updated_at
    end
  end

end
