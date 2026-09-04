class RegistrationsController < ApplicationController
  before_action :require_authentication!, only: %i[edit update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(registration_params)

    if @user.save
      reset_session
      session[:user_id] = @user.id
      redirect_to edit_registration_path, notice: "Account saved. Continue registration now or resume later."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    redirect_to root_path, notice: "Registration is already complete." if current_user.registration_complete?
  end

  def update
    if params[:commit_registration] == "1"
      current_user.update!(registration_completed_at: Time.current)
      redirect_to root_path, notice: "Registration completed. Your membership remains pending approval."
    else
      redirect_to root_path, notice: "Registration progress saved. You can resume later."
    end
  end

  private

  def registration_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
