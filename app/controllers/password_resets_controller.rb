class PasswordResetsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email].to_s.strip.downcase)

    if user
      token = user.generate_token_for(:password_reset)
      reset_url = "#{application_base_url}/password/reset/#{token}"
      PasswordResetMailer.with(user: user, reset_url: reset_url).reset.deliver_later
    end

    redirect_to new_session_path, notice: "If that email exists, password recovery instructions have been prepared."
  end

  def edit
    @user = User.find_by_token_for(:password_reset, params[:token])
    return if @user

    redirect_to new_password_reset_path, alert: "That password recovery link is invalid or has expired."
  end

  def update
    @user = User.find_by_token_for(:password_reset, params[:token])

    unless @user
      redirect_to new_password_reset_path, alert: "That password recovery link is invalid or has expired."
      return
    end

    if @user.update(password_params)
      reset_session
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Password updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def application_base_url
    ENV.fetch("APP_BASE_URL", "http://localhost:3000").delete_suffix("/")
  end

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
