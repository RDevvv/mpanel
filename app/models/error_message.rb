class ErrorMessage < ActiveRecord::Base
  attr_accessible :app_name, :class_name, :doc_root, :message, :params, :referer_url, :target_url, :trace, :user_agent, :user_info
end
