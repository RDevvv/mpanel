class UserAccount < ActiveRecord::Base
  attr_accessible :account_id, :user_id, :deleted_at
  belongs_to :account
  belongs_to :user
  acts_as_paranoid
end
