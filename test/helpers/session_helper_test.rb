require "test_helper"

describe SessionHelper do
  include SessionHelper

  describe "current_user" do
    it "finds the current user from the user_id in the session" do
      stub_user = build(:user)
      User.expects(:where).with(id: 12345).returns([stub_user])
      session[:user_id] = 12345

      assert_equal stub_user, current_user
    end

    it "returns nil if no user can be found with the id" do
      User.expects(:where).with(id: 12345).returns([])
      session[:user_id] = 12345

      assert_equal nil, current_user
    end

    it "returns nil if user_id session variable is set" do
      session[:user_id] = nil
      assert_equal nil, current_user
    end
  end

  describe "user_signed_in?" do
    it "is true if current_user is present" do
      stub_user = build(:user)
      stubs(:current_user).returns(stub_user)
      assert user_signed_in?
    end

    it "is false if current_user is nil" do
      stubs(:current_user).returns(nil)
      refute user_signed_in?
    end
  end

end
