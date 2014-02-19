require "test_helper"

describe EateriesController do

  it "redirects to the sign in form for an unauthenticated request" do
    @controller.session[:user_id] = nil
    get :index

    assert_redirected_to new_session_path
  end

end
