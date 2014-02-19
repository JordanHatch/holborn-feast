require "test_helper"

describe Recommendation do

  it "can be created given a user and an eatery" do
    user = create(:user)
    eatery = create(:eatery)
    recommendation = Recommendation.new(user: user, eatery: eatery)

    assert recommendation.valid?
    assert recommendation.save
    assert recommendation.persisted?
  end

  it "rejects duplicate recommendations" do
    user = create(:user)
    eatery = create(:eatery)

    Recommendation.create!(user: user, eatery: eatery)
    recommendation = Recommendation.new(user: user, eatery: eatery)

    refute recommendation.valid?
    assert recommendation.errors.has_key?(:user_id)
    assert recommendation.errors.has_key?(:eatery_id)
  end

end
