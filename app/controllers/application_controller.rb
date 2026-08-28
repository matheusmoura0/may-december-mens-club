class ApplicationController < ActionController::Base
  helper_method :current_user, :signed_in?

  private

  def current_user
    return @current_user if defined?(@current_user)

    @current_user = User.find_by(id: session[:user_id])
  end

  def signed_in?
    current_user.present?
  end

  def require_authentication!
    return if signed_in?

    redirect_to new_session_path, alert: "Please sign in to continue."
  end

  def require_active_member!
    require_authentication!
    return unless performed?
    return if current_user&.active?

    redirect_to root_path, alert: "Your membership is not active."
  end
end
