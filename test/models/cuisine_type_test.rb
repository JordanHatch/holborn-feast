require 'test_helper'

describe CuisineType do

  def valid_atts
    { name: "Italian" }
  end

  it "can be created with valid attributes" do
    cuisine_type = CuisineType.new(valid_atts)

    assert cuisine_type.valid?
    assert cuisine_type.save
    assert cuisine_type.persisted?
  end

  it "builds a friendly id" do
    cuisine_type = CuisineType.create!(valid_atts)

    assert_equal "italian", cuisine_type.slug
  end

  it "is invalid with a duplicate name" do
    CuisineType.create!(valid_atts)

    cuisine_type = CuisineType.new(valid_atts.slice(:name))

    refute cuisine_type.valid?
    assert cuisine_type.errors.has_key?(:name)
  end

end
