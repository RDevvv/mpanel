class CallForwarding < ActiveRecord::Base
  belongs_to :outlet
  belongs_to :customer
  # attr_accessible :title, :body
end
