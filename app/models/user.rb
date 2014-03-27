class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :subscribe_email_updates, :subscribe_crm_updates
  attr_accessible :first_name,:last_name,:mobile_number,:user_key,:is_active,:email_verified,:mobile_verified
  has_many :user_accounts, :dependent => :destroy
  has_many :accounts, :through => :user_accounts
  has_many :user_brands, :dependent => :destroy
  has_many :brands, :through => :user_brands
  # attr_accessible :title, :body
  # validates_presence_of :first_name, :last_name
  # validates_format_of :email, :with => /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/
  has_one :avatar, :as => :attachable ,:class_name=>'Attachment'
  after_create :add_admin
  
  def add_account(account)
    UserAccount.create(:account_id=>account.id, :user_id=>self.id)
  end  

  def add_admin
    self.add_role :outlet_manager
  end

  def user_name
    (self.first_name+ " "+ self.last_name).strip
  end

  def name
    (self.first_name+ " "+ self.last_name).strip
  end

end
