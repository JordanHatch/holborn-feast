require "test_helper"

describe SessionsController do

  describe "GET new" do
    it "renders the view" do
      get :new

      assert response.success?
      assert_template "new"
    end
  end

  describe "GET create" do
    before(:each) do
      @stub_user = create(:user)
      request.env['omniauth.auth'] = "an auth hash"
    end

    it "looks for a user given an auth hash" do
      User.expects(:find_or_create_from_auth_hash).with("an auth hash").returns(@stub_user)
      get :create, provider: "google"
    end

    it "sets the user in the session given a valid auth hash" do
      User.expects(:find_or_create_from_auth_hash).with("an auth hash").returns(@stub_user)
      get :create, provider: "google"

      assert_equal @stub_user.id, @controller.session[:user_id]
    end

    it "redirects to the root given a valid auth hash" do
      User.expects(:find_or_create_from_auth_hash).with("an auth hash").returns(@stub_user)
      get :create, provider: "google"

      assert_redirected_to root_path
    end

    it "redirects to the sign in form given no auth hash" do
      request.env['omniauth.auth'] = nil
      get :create, provider: "google"

      assert_redirected_to new_session_path
    end

    it "redirects to the sign in form if no user is present" do
      User.expects(:find_or_create_from_auth_hash).with("an auth hash").returns(nil)
      get :create, provider: "google"

      assert_redirected_to new_session_path
    end

    it "redirects to the sign in form with a custom error if the email address is rejected" do
      User.expects(:find_or_create_from_auth_hash).with("an auth hash").raises(User::EmailNotPermitted)
      get :create, provider: "google"

      assert_redirected_to new_session_path
      assert_equal "Please sign in using your GDS account.", @controller.flash[:error]
    end
  end

  describe "DELETE destroy" do
    it "sets the user_id session variable to nil" do
      @controller.session[:user_id] = 1234
      delete :destroy

      assert_equal nil, @controller.session[:user_id]
      assert_redirected_to new_session_path
    end

    it "doesn't break if the user_id session variable is blank" do
      @controller.session[:user_id] = nil
      delete :destroy

      assert_equal nil, @controller.session[:user_id]
      assert_redirected_to new_session_path
    end
  end

end
