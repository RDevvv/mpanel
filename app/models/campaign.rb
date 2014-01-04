class Campaign < ActiveRecord::Base
  attr_accessible :expires_at, :keyword, :marketer, :medium, :post_expiry_forward_url, :pre_expiry_forward_url, :short_url, :source, :type, :unique_key
end
