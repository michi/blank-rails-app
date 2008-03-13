class Mailer < ActionMailer::Base
  def new_password_notification(user, password)
    setup_email(user)
    @body[:password] = password
    @subject += "New password on localhost"
  end
  
  protected
  
  def setup_email(user)
    @recipients  = "#{user.email}"
    @from        = "Localhost <no-reply@localhost>"
    @subject     = "[Localhost] "
    @sent_on     = Time.now
    @body[:user] = user
  end
end