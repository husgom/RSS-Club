ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :address        => 'mail.husey.in',
  :port           => 25,
  :domain         => 'husey.in',
  :authentication => :login,
  :user_name      => 'info+husey.in',
  :password       => 'Q7QMkKN#'
}
