class Emailer < ActionMailer::Base
  default :from => "gullakmaster.com"
  
  def registration_confirmation(users)
  	@users = users
  	@users.each do |user|
  		mail(:to => "#{user.first_name} #{user.last_name} <#{user.email}>", :subject => "Registered")
  	end
  end
end
