class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,:confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :first_name,:last_name,:mobile_number,:user_key,:is_active,:email_verified,:mobile_verified
  has_many :user_accounts, :dependent => :destroy
  has_many :accounts, :through => :user_accounts
  # attr_accessible :title, :body
  # validates_presence_of :first_name, :last_name
  # validates_format_of :email, :with => /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/
  has_one :avatar, :as => :attachable ,:class_name=>'Attachment'

  def user_name
    (self.first_name+ " "+ self.last_name).strip
  end

  def name
    (self.first_name+ " "+ self.last_name).strip
  end
  
end
