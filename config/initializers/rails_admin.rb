RailsAdmin.config do |config|
  config.main_app_name = ['Gullak2', 'Admin']
  config.current_user_method { current_admin_user }
  config.audit_with :paper_trail, 'User'
end  