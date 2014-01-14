class Emailer < ActionMailer::Base
  default :from => "merchant@gullakmaster.com"
  
  def account_confirmation(users,account)
  	@users = users
    @account = account
  	@users.each do |user|
  		mail(:to => user.email, :subject => "Account Created")
  	end
  end

  def registration_confirmation(user,current_user)
    @user = user
  	mail(:to => @user.email, :cc=> current_user.email, :subject => "Registered")
  end
end
