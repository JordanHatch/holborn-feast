class SessionsController < ApplicationController
  skip_before_filter :authenticate!

  def new
    # new.html.erb
  end

  def create
    unless auth_hash.present?
      fail_and_redirect
      return
    end

    @user = User.find_or_create_from_auth_hash(auth_hash)
    if @user.present?
      session[:user_id] = @user.id
      redirect_to root_path
    else
      fail_and_redirect
    end
  rescue User::EmailNotPermitted
    fail_and_redirect "Please sign in using your GDS account."
  end

  def destroy
    session[:user_id] = nil
    redirect_to new_session_path
  end

  private

  def fail_and_redirect(message="There was a problem signing you in.")
    flash[:error] = message
    redirect_to new_session_path
  end

  def auth_hash
    request.env['omniauth.auth']
  end

end
