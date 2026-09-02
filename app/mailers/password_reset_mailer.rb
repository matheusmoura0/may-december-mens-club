class PasswordResetMailer < ApplicationMailer
  def reset
    @user = params[:user]
    @reset_url = params[:reset_url]

    mail(to: @user.email, subject: "Reset your May December Men's Club password")
  end
end
