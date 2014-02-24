require "test_helper"

describe RecommendationsController do

  before(:each) do
    stub_user_session
    @eatery = create(:eatery)
  end

  describe "PUT update" do
    it "creates a recommendation for the current user" do
      put :update, eatery_id: @eatery.to_param

      assert_redirected_to eatery_path(@eatery.to_param)
      assert_equal "Thanks for recommending this eatery.", @controller.flash[:notice]
      assert_equal nil, @controller.flash[:error]

      assert_equal 1, Recommendation.where(user: stub_user, eatery: @eatery).count
    end

    it "maintains an existing recommendation for the current user" do
      Recommendation.create!(user: stub_user, eatery: @eatery)

      put :update, eatery_id: @eatery.to_param

      assert_redirected_to eatery_path(@eatery.to_param)
      assert_equal "Thanks for recommending this eatery.", @controller.flash[:notice]
      assert_equal nil, @controller.flash[:error]

      assert_equal 1, Recommendation.where(user: stub_user, eatery: @eatery).count
    end

    it "returns a 404 given an invalid eatery" do
      put :update, eatery_id: "foo"

      assert response.not_found?
    end
  end

  describe "DELETE destroy" do
    it "deletes the recommendation for the current user" do
      Recommendation.create!(user: stub_user, eatery: @eatery)

      delete :destroy, eatery_id: @eatery.to_param

      assert_redirected_to eatery_path(@eatery.to_param)
      assert_equal "The recommendation has been removed.", @controller.flash[:notice]
      assert_equal nil, @controller.flash[:error]

      assert_equal 0, Recommendation.where(user: stub_user, eatery: @eatery).count
    end

    it "returns an error if no recommendation exists" do
      delete :destroy, eatery_id: @eatery.to_param

      assert_redirected_to eatery_path(@eatery.to_param)
      assert_equal "No recommendation could be found for this eatery.", @controller.flash[:error]
      assert_equal nil, @controller.flash[:notice]
    end

    it "returns a 404 given an invalid eatery" do
      delete :destroy, eatery_id: "foo"

      assert response.not_found?
    end
  end

end
