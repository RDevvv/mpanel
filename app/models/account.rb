class Account < ActiveRecord::Base
  resourcify
  attr_accessible :account_balance, :registered_company_name, :account_key, :address,:owner_id, :area_id, :currency_id, :is_active, :is_deleted, :is_verified, :payment_status, :users_attributes, :deleted_at
  has_many :account_brands, :dependent => :destroy
  has_many :brands, :through => :account_brands
  has_many :user_accounts, :dependent => :destroy
  has_many :users, :through => :user_accounts
  belongs_to :area
  
  acts_as_paranoid  
  # validates_presence_of :registered_company_name, :address
  accepts_nested_attributes_for :users,:area
  # validates :registered_company_name, :format => { :with => /\A[a-zA-Z0-9]+\z/,:message => "Invalid Company Name" }
  # validates :pincode, :presence => true, :numericality => {:greater_than => 0, :message => " is an invalid pincode."}
  after_create :add_owner
  
  def add_owner
    self.users.first.add_role :owner,self
  end

  def owner
    # self.users.select{|u| u.has_role?(:owner,self) }.first
  end

  def name
    registered_company_name
  end

  def add_default_admin_user
    if User.find_by_email("merchant@gullakmaster.com").present?
      self.users << user
    else
      User.create(:email => "merchant@gullakmaster.com", :password => "gmkg2013", :password_confirmation => "gmkg2013", :first_name => "Abhishek", :last_name => "Dadoo", :mobile_number => "983000000000", :user_key => "abcdef", :is_active => true, :email_verified => true, :mobile_verified => false)
    end
  end

end
