class ButtonClick < ActiveRecord::Base
  belongs_to :customer
  belongs_to :ad
  belongs_to :outlet
  belongs_to :customer_session

  attr_accessible :ad_id, :outlet_id, :button_class, :customer_id, :customer_session_id, :previous_link, :current_link, :ad_version_id, :outlet_version_id

  validates :button_class, :presence => true
  validates :previous_link, :presence => true
  validates :current_link, :presence => true

  after_create :add_version_details

  def add_version_details
      self.update_attributes(:ad_version_id => self.ad.versions.last.id, :outlet_version_id => self.outlet.versions.last.id)
  end
end
