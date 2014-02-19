require "test_helper"

describe EateriesController do

  before(:each) do
    stub_user_session
  end

  it "redirects to the sign in form for an unauthenticated request" do
    @controller.session[:user_id] = nil
    get :index

    assert_redirected_to new_session_path
  end

  describe "GET index" do
    it "assigns a collection of eateries" do
      stub_view_rendering # we're not testing the view here

      stub_eatery = build(:eatery)
      Eatery.expects(:all).returns([stub_eatery])
      get :index

      assert_equal [stub_eatery], assigns(:eateries)
    end

    it "renders the index template" do
      get :index

      assert_template "index"
    end
  end

end
