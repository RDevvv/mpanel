class Attachment < ActiveRecord::Base

  attr_accessible :attachable_id, :attachable_type, :image,:image_cache
  mount_uploader :image, ImageUploader
  belongs_to :attachable, :polymorphic => true  
end
