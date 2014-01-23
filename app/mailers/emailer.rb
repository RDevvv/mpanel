class Emailer < ActionMailer::Base
  default :from => "merchant@gullakmaster.com"
  
  def account_confirmation(user,account)
    @user = user
    @account = account
  	mail(:to => @user.email, :subject => "Account Created")
  end

  def registration_confirmation(user,account)
    @user = user
    @account = account
  	mail(:to => @user.email, :subject => "Registered")
  end

  def user_confirmation(user,account)
    @user = user
    @account = account
    mail(:to => @user.email, :subject => "Access Authority")
  end

end
