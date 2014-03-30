class Mall < ActiveRecord::Base
  attr_accessible :area_id, :latitude, :longitude, :name
  belongs_to :area
  has_many :attachments, :as => :attachable ,:class_name=>'Attachment'
end
