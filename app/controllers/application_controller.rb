class ApplicationController < ActionController::Base
  include SessionHelper

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :authenticate!

  private

  def authenticate!
    unless user_signed_in?
      redirect_to new_session_path
      false
    end
  end

  def error_404
    raise ActionController::RoutingError.new('Not Found')
  end
end
