ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "gullakmaster.com",
  :user_name            => "merchant@gullakmaster.com",
  :password             => "gmkg2013",
  :authentication       => "plain",
  :enable_starttls_auto => true
}
# require 'development_mail_interceptor' #add this line
# ActionMailer::Base.register_interceptor(DevelopmentMailInterceptor) if  Rails.env.development?