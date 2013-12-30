class MobileVerificationCode < ActiveRecord::Base
  belongs_to :customer
  attr_accessible :verification_code
end
