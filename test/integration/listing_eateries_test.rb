require "integration_test_helper"

class ListingEateriesTest < ActionDispatch::IntegrationTest
  before do
    sign_in_user
  end

  it "lists eateries in alphabetical order" do
    create(:eatery, name: "Eat")
    create(:eatery, name: "Pret")
    create(:eatery, name: "Chipotle")

    visit eateries_path

    within ".eateries ul" do
      within "li:nth-of-type(1)" do
        assert page.has_content?("Chipotle")
      end

      within "li:nth-of-type(2)" do
        assert page.has_content?("Eat")
      end

      within "li:nth-of-type(3)" do
        assert page.has_content?("Pret")
      end
    end
  end

  it "shows the number of recommendations for each eatery" do
    eateries = [
      create(:eatery_with_recommendations, recommendations: 5),
      create(:eatery_with_recommendations, recommendations: 3),
      create(:eatery_with_recommendations, recommendations: 0)
    ]

    visit eateries_path

    within ".eateries ul" do
      assert page.has_selector?("span.recommendation-count", text: "5 ♥︎")
      assert page.has_selector?("span.recommendation-count", text: "3 ♥︎")
      assert page.has_selector?("span.recommendation-count", text: "0 ♥︎")
    end
  end

end
