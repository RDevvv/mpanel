ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "gullakmaster.com",
  :user_name            => "marketing@gullakmaster.com",
  :password             => "aw#eft^yji(",
  :authentication       => "plain",
  :enable_starttls_auto => true
}

Mail.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?