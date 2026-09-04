class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email].to_s.strip.downcase)

    if user&.authenticate(params[:password])
      reset_session
      session[:user_id] = user.id

      if user.registration_complete?
        redirect_to root_path, notice: "Signed in successfully."
      else
        redirect_to edit_registration_path, notice: "Signed in. Resume your saved registration."
      end
    else
      flash.now[:alert] = "Invalid email or password."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    reset_session
    redirect_to root_path, notice: "Signed out successfully."
  end
end
