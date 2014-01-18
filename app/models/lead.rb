class Lead < ActiveRecord::Base
  attr_accessible :company_name, :designation, :email, :first_name, :last_name, :mobile_number, :source, :subscribe_email_updates, :target

  validates :company_name, :presence => true
  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :source, :presence => true
  validates :designation, :presence => true
  validates :target, :presence => true
  validates :email, :uniqueness => { :case_sensitive => false }
  validates :mobile_number, :uniqueness => true, :numericality => true,:length => {:minimum => 9, :maximum => 11}, :allow_blank => true
  validates :subscribe_email_updates, :inclusion => {:in => [true, false]}
end
