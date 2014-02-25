require 'test_helper'

describe Eatery do

  def valid_atts
    {
      name: "Chipotle",
      lat: 51.514782,
      lon: -0.129747,
      description: "This place is good."
    }
  end

  it "can be created with valid attributes" do
    eatery = Eatery.new(valid_atts)

    assert eatery.valid?
    assert eatery.save
    assert eatery.persisted?
  end

  it "builds a friendly id" do
    eatery = Eatery.create!(valid_atts)

    assert_equal "chipotle", eatery.slug
  end

  it "is invalid without a name" do
    eatery = Eatery.new(valid_atts.merge(name: ""))

    refute eatery.valid?
    assert eatery.errors.has_key?(:name)
  end

  it "returns users who have recommended it" do
    eatery = create(:eatery)
    user = create(:user)
    recommendation = eatery.recommendations.create!(user: user)

    eatery.reload

    assert_equal [user], eatery.recommended_by
  end

end
