class ReferrerDownloadCount < ActiveRecord::Base
  belongs_to :customer
  attr_accessible :download_count, :customer_id

  validates :customer_id, :uniqueness => true
end
