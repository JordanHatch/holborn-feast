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
      eatery = create(:eatery)
      get :index

      assert_equal [eatery], assigns(:eateries)
    end

    it "renders the index template" do
      get :index

      assert_template "index"
    end
  end

  describe "GET show" do
    it "returns a 404 for an eatery which does not exist" do
      get :show, id: "blah"

      assert response.not_found?
    end

    it "finds an eatery from its friendly id" do
      stub_view_rendering

      stub_eatery = build(:eatery)

      friendly_scope = mock("friendly scope")
      Eatery.expects(:friendly).returns(friendly_scope)
      friendly_scope.expects(:find).with("a-slug").returns(stub_eatery)

      get :show, id: "a-slug"
      assert_equal stub_eatery, assigns(:eatery)
    end

    it "renders the show template" do
      eatery = create(:eatery)

      get :show, id: eatery.to_param

      assert response.ok?
      assert_template "show"
    end
  end

  describe "GET new" do
    it "assigns a blank eatery" do
      get :new

      assert assigns(:eatery).is_a?(Eatery)
      refute assigns(:eatery).persisted?
    end

    it "renders the new template" do
      get :new

      assert response.ok?
      assert_template "new"
    end
  end

  describe "POST create" do
    before(:each) do
      @valid_atts = {
        "name" => "The Rose and Crown",
        "lat" => "50.0000",
        "lon" => "-1.0000",
        "description" => "Classic British pub food."
      }
    end

    it "creates a new eatery given valid attributes" do
      post :create, eatery: @valid_atts

      eatery = assigns(:eatery)

      assert eatery.persisted?
      assert_redirected_to eatery_path(eatery.to_param)
    end

    it "only includes valid parameters" do
      mock_eatery = mock("Eatery", save: true)
      Eatery.expects(:new).with {|hash|
        hash.keys.sort == ["description", "lat", "lon", "name"]
      }.returns(mock_eatery)

      post :create, eatery: @valid_atts.merge("evil" => "value")
    end

    it "renders the new template when the eatery does not save" do
      post :create, eatery: @valid_atts.merge("name" => "")

      eatery = assigns(:eatery)

      refute eatery.persisted?
      assert_template "new"
    end
  end

  describe "GET edit" do
    it "returns a 404 for an eatery which does not exist" do
      get :edit, id: "blah"

      assert response.not_found?
    end

    it "renders the edit template" do
      eatery = create(:eatery)

      get :edit, id: eatery.to_param

      assert response.ok?
      assert_template "edit"
    end
  end

  describe "PUT update" do
    it "returns a 404 for an eatery which does not exist" do
      put :update, id: "blah", eatery: { "name" => "Foo" }

      assert response.not_found?
    end

    it "updates an eatery given valid parameters" do
      eatery = create(:eatery)
      put :update, id: eatery.to_param, eatery: { "name" => "The Fox and Hound" }

      assert_redirected_to eatery_path(eatery)

      eatery.reload
      assert_equal "The Fox and Hound", eatery.name
    end

    it "renders the edit template given invalid parameters" do
      eatery = create(:eatery, name: "The Black Bull")
      put :update, id: eatery.to_param, eatery: { "name" => "" }

      assert_template "edit"

      eatery.reload
      assert_equal "The Black Bull", eatery.name
    end
  end

end
