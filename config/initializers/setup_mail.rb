ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "gullakmaster.com",
  :user_name            => "dhatrak.gayatri@gmail.com",
  :password             => "alibabamilgayachalischorose",
  :authentication       => "plain",
  :enable_starttls_auto => true
}

Mail.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?