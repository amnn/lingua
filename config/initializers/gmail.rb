ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => 'gmail.com',
  :user_name            => 'lingua.confirm@gmail.com', # full email address (user@your.host.name.com)
  :password             => 'herokuActionMailer',
  :authentication       => 'plain',
  :enable_starttls_auto => true
}