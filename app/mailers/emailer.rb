class Emailer < ActionMailer::Base
  default :from => "merchant@gullakmaster.com"
  
  def registration_confirmation(users)
  	@users = users
  	@users.each do |user|
  		mail(:to => user.email, :subject => "Registered")
  	end
  end
end
