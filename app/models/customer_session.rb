class CustomerSession < ActiveRecord::Base
  belongs_to :customer
  attr_accessible :browser, :browser_version, :platform, :referer_link
end
