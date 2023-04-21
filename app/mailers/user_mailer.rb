class UserMailer < ApplicationMailer

  def send_pending_email(email)
    mail( to: email,
    subject: 'Account Activation Required' )
  end 

  def send_activated_email(email)
    mail( to: email,
    subject: 'Account Activated' )
  end

end