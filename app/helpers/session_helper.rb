module SessionHelper
  def current_user
    if session[:user_id].present?
      @current_user ||= User.where(id: session[:user_id]).first
    end
  end

  def user_signed_in?
    current_user.present?
  end
end
