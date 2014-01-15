class Emailer < ActionMailer::Base
  default :from => "merchant@gullakmaster.com"
  
  def account_confirmation(users,account)
    emails = users.pluck(:email)
    @account = account
  	mail(:to => emails, :subject => "Account Created")
  end

  def registration_confirmation(user,current_user)
    @user = user
  	mail(:to => @user.email, :cc=> current_user.email, :subject => "Registered")
  end

end
